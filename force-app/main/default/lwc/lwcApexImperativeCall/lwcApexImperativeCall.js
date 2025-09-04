import { LightningElement,track } from 'lwc';

import getParkerRecords from '@salesforce/apex/ParkerPenApexClass.getParkerRecords';

export default class LwcApexImperativeCall extends LightningElement {
    @track records;
    @track error;
    
    HandleApexImperativeCall(event){
        getParkerRecords().then(results => {
            this.records = results;
        })
        .catch(error => {
            this.error = error;
        });
    }


}