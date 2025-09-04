import { LightningElement,track,wire } from 'lwc';

import getAccountRecords from '@salesforce/apex/AccountObjectApexClass.getAccountRecords';

export default class WireLwcFunction extends LightningElement {
    @track accounts;
    @track error;

    @wire(getAccountRecords)
    wireAccountObject({error,data}){
        if(data){
            this.accounts = data;

        }else if(error){
            this.error = error;
        }
    }
}