import { LightningElement,wire,track } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import FirstName_Field from '@salesforce/schema/Contact.FirstName';
import LastName_Field from '@salesforce/schema/Contact.LastName';
import Email_Field from '@salesforce/schema/Contact.Email';

import getContacts from '@salesforce/apex/ContactController.getContacts';


const COLUMNS = [
    { label: 'First Name', fieldName: FirstName_Field.fieldApiName, type: 'text' },
    { label: 'Last Name', fieldName: LastName_Field.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: Email_Field.fieldApiName, type: 'Email' }
];

export default class ContactList extends LightningElement {

    columns= COLUMNS;
    @track
    error;
    @track
    ListOfContacts;
    @wire(getContacts)
    wiredContacts({data,error}){
        if(data){
            this.ListOfContacts = data;
        }else if(error){
            this.error = reduceErrors(error);
        }
    }

    get errors(){
        return this.error;
    }

}