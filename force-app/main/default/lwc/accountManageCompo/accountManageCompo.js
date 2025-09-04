import { LightningElement, track } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountHandler.getAllAccounts';
import updateAccountStatus from '@salesforce/apex/AccountHandler.updateAccountStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountManageCompo extends LightningElement {
    showGreeting = true;
    showTable = false;
    isLoading = false;
    showNoRecords = false;
    accountData = [];
    error;
    hideCheckbox = false;

    selectedRowIds = [];
    currentStatus = null;

    showModal = false;
    selectedAccountContacts = [];

    columns = [
        {
            label: 'Account Id',
            fieldName: 'Id',
            type: 'button',
            typeAttributes: {
                label: { fieldName: 'Id' },
                name: 'view_contacts',
                variant: 'base'
            }
        },
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Status', fieldName: 'Statusicon', type: 'text' }
    ];

    get isActivateDisabled() {
        return this.currentStatus === true || this.selectedRowIds.length === 0;
    }

    get isInactivateDisabled() {
        return this.currentStatus === false || this.selectedRowIds.length === 0;
    }

    getData(param) {
        this.isLoading = true;
        this.selectedRowIds = [];
        this.currentStatus = param;

        getAllAccounts({ varStatus: param })
            .then(result => {
                this.accountData = result.map(acc =>({
                    ...acc,
                     'Statusicon': acc.Active__c ? 'Active' : 'Inactive'
                    })) || [];
                this.showGreeting = false;
                this.showTable = true;
                this.showNoRecords = this.accountData.length === 0 ? true : false;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.showGreeting = false;
                this.showTable = false;
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    handleActiveClick() {
        this.getData(true);
    }

    handleInactiveClick() {
        this.getData(false);
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedRowIds = selectedRows.map(row => row.Id);
    }

    handleRowAction(event) {
        const accountId = event.detail.row.Id;
        const selectedAccount = this.accountData.find(acc => acc.Id === accountId);
        this.selectedAccountContacts = selectedAccount?.Contacts || [];
        this.showModal = true;
    }

    handleActivate() {
        this.updateSelectedRecords(true);
    }

    handleInactivate() {
        this.updateSelectedRecords(false);
    }

    updateSelectedRecords(newStatus) {
        this.isLoading = true;
        updateAccountStatus({ accountIds: this.selectedRowIds, newStatus: newStatus })
            .then(() => {
                this.showToast('Success', 'Accounts updated successfully', 'success');
                this.getData(this.currentStatus);
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    closeModal() {
        this.showModal = false;
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}