import { LightningElement,wire } from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountObjectApexClass.getAccountRecords';

export default class WirePropertyLwc extends LightningElement {

    @wire (getAccountRecords)
    accounts;
    
}