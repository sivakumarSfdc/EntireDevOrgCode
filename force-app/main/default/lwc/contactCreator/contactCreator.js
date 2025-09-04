import { LightningElement } from 'lwc';
import Contact_OBJECT from '@salesforce/schema/Contact';
import FirstName_FIELD from '@salesforce/schema/Contact.FirstName';
import LastName_FIELD from '@salesforce/schema/Contact.LastName';
import Email_Field from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {

    objectApiName = Contact_OBJECT;
    fields = [FirstName_FIELD, LastName_FIELD, Email_Field];
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }

}