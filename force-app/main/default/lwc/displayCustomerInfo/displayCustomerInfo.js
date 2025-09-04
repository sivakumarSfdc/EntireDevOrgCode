import { LightningElement, track, wire, api } from 'lwc';
import GetCustomerInformation from '@salesforce/apex/bankAccountsManager.GetCustomerInformation';

export default class DisplayCustomerInfo extends LightningElement {
    @track records;
    @track error;
    @api recordId;
    isNoChild;

    columns = [
        { label: 'Bank', fieldName: 'parentName', type: 'text' },
        { label: 'Customer Name', fieldName: 'childName', type: 'text' },
        { label: 'Account Number', fieldName: 'accNumber', type: 'text' },
        { label: 'Phone', fieldName: 'mobile', type: 'text' },
        { label: 'Branch', fieldName: 'branch', type: 'text' }
    ];

    @wire(GetCustomerInformation, { recId: '$recordId' })
    wireBankObject({ error, data }) {
        if (data) {
            this.records = data;
            this.isNoChild = this.records.every(record => !record.Bank_Accounts__r || record.Bank_Accounts__r.length === 0);
        } else if (error) {
            this.error = error;
        }
    }

    get combinedData() {
        let combinedData = [];
        if (this.records) {
            this.records.forEach(record => {
                if (record.Bank_Accounts__r && record.Bank_Accounts__r.length > 0) {
                    record.Bank_Accounts__r.forEach(childRecord => {
                        combinedData.push({
                            recordId: record.Id,
                            parentName: record.Name,
                            childName: childRecord.Name,
                            accNumber: childRecord.Account_Number__c,
                            mobile: childRecord.Mobile__c,
                            branch: childRecord.RecordType.Name
                        });
                    });
                }
            });
        }
        return combinedData;
    }
}