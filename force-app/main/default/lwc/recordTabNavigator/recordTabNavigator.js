import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToRecordPage extends NavigationMixin(LightningElement) {
    navigateToRecord() {
        // Replace with the actual record ID you want to navigate to
        const recordId = '001J300000K6hkTIAR'; // Example Account ID
        const objectApiName = 'Account'; // Change as needed

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: objectApiName,
                actionName: 'view'
            },
            state: {
            nooverride: '1',              // Prevents override by Visualforce
            c__activeTab: 'testtab'       // Custom param to track tab

            }
        });
    }
}