import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import getContacts from '@salesforce/apex/LeadContactSelectorController.getContacts';
import updateLead from '@salesforce/apex/LeadContactSelectorController.updateLead';
import createContactForLead from '@salesforce/apex/LeadContactSelectorController.createContactForLead';

export default class LeadContactSelector extends LightningElement {
    _recordId;
    @track contacts = [];
    @track selectedContactId;
    @track isLoading = true;
    @track hasError = false;
    @track errorMessage;

    // Use setter so loadContacts runs when recordId is injected by Salesforce
    @api
    set recordId(value) {
        this._recordId = value;
        if (value) {
            this.loadContacts();
        }
    }
    get recordId() {
        return this._recordId;
    }

    async loadContacts() {
        this.isLoading = true;
        this.hasError = false;
        this.errorMessage = null;

        try {
            const result = await getContacts({ leadId: this.recordId });
            this.contacts = result;
            this.isLoading = false;
        } catch (error) {
            this.contacts = [];
            this.hasError = true;
            this.errorMessage = error?.body?.message || 'Error loading contacts';
            this.showErrorToast(this.errorMessage);
        } finally {
            this.isLoading = false;
        }
    }

    get hasContacts() {
        return this.contacts && this.contacts.length > 0;
    }

    get contactOptions() {
        return this.contacts.map(con => ({ label: con.Name, value: con.Id }));
    }

    get disableContinue() {
        return !this.selectedContactId;
    }

    handleRadioChange(event) {
        this.selectedContactId = event.detail.value;
    }

    async handleContinue() {
        try {
            await updateLead({ leadId: this.recordId, contactId: this.selectedContactId });
            this.showSuccessToast('Lead updated with Primary Contact');
            this.closeModal();
            eval("$A.get('e.force:refreshView').fire();");
        } catch (error) {
            this.showErrorToast(error?.body?.message || 'Error updating Lead');
        }
    }

    async createContact() {
        try {
            const contactId = await createContactForLead({ leadId: this.recordId });
            await updateLead({ leadId: this.recordId, contactId });
            this.showSuccessToast('Lead updated with new Primary Contact');
            this.closeModal();
            eval("$A.get('e.force:refreshView').fire();");
        } catch (error) {
            this.showErrorToast(error?.body?.message || 'Error creating Contact');
        }
    }

    closeModal() {
        this.dispatchEvent(new CloseActionScreenEvent());
        try {
            eval("$A.get('e.force:closeQuickAction').fire();");
        } catch (e) {
            // ignore
        }
    }

    showErrorToast(message) {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Error',
            message,
            variant: 'error'
        }));
    }

    showSuccessToast(message) {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message,
            variant: 'success'
        }));
    }
}