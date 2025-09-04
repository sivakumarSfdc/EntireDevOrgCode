import { LightningElement, wire, track } from 'lwc';
import fetchAccounts from '@salesforce/apex/DisplayAccounts.fetchAccounts';
import deleteAccount from '@salesforce/apex/DisplayAccounts.deleteAccount';

import { NavigationMixin } from 'lightning/navigation';
import { subscribe, onError } from 'lightning/empApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const actions = [
    { label: 'View', name: 'view' },
    { label: 'Edit', name: 'edit' },
    { label: 'Delete', name: 'delete' }
];

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Active', fieldName: 'Active__c' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions }
    }
];

export default class DisplayAccountsTable extends NavigationMixin(LightningElement) {
    @track data;
    @track error;
    wiredData;
    columns = columns;
    subscription = {};
    searchTerm = '';

    // Platform event channel name
    channelName = '/event/RecordUpdateEvent__e';

    @wire(fetchAccounts, { searchTerm: '$searchTerm' })
    wiredMethod(result) {
        this.wiredData = result;
        if (result.data) {
            this.data = result.data;
            this.error = undefined;
        } else if (result.error) {
            console.log('Data fetching error: ' + JSON.stringify(result.error));
            this.error = result.error;
            this.data = undefined;
        }
    }

    connectedCallback() {
        this.handleSubscribe();
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('New message received: ', JSON.stringify(response));
            this.showToast('Record Updated', 'A record was updated successfully', 'success');
            this.refreshData();
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
        });

        // Error handling
        onError(error => {
            console.error('Received error from server: ', JSON.stringify(error));
        });
    }

    handleUnsubscribe() {
        unsubscribe(this.subscription, response => {
            console.log('Unsubscribe response: ', JSON.stringify(response));
        });
    }

    handleAction(event) {
        const eventName = event.detail.action.name;
        const eventRow = event.detail.row;
        switch (eventName) {
            case 'view':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: eventRow.Id,
                        actionName: 'view',
                        objectApiName: 'Account'
                    }
                });
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: eventRow.Id,
                        actionName: 'edit',
                        objectApiName: 'Account'
                    }
                });
                break;
            case 'delete':
                this.deleteRecord(eventRow.Id);
                break;
        }
    }

    deleteRecord(recordId) {
        deleteAccount({ recordId: recordId })
            .then(() => {
                this.showToast('Success', 'Record deleted successfully', 'success');
                this.refreshData();
            })
            .catch(error => {
                this.showToast('Error', 'Error deleting record: ' + error.body.message, 'error');
            });
    }

    refreshData() {
        return refreshApex(this.wiredData);
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    handleInputChange(event) {
        this.searchTerm = event.target.value;
    }
}