import { LightningElement, api, track } from 'lwc';
import searchRecords from '@salesforce/apex/DynamicSearchController.searchRecords';

export default class DynamicSearch extends LightningElement {
    @api objectName = '';
    @api filterFields = '';
    @api displayFields = '';
    @track filterFieldValue = '';
    @track results = [];
    @track columns = [];
    @track error;

    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'filterFieldValue') {
            this.filterFieldValue = event.target.value;
        }
    }

    handleSearch() {
        const inputValues = {};
        this.filterFields.split(',').forEach(field => {
            inputValues[field.trim()] = this.filterFieldValue;
        });

        searchRecords({ objectName: this.objectName, filterFields: this.filterFields, displayFields: this.displayFields, inputValues: inputValues })
            .then(result => {
                this.results = result;
                this.error = undefined;
                this.columns = this.displayFields.split(',').map(field => ({
                    label: field.trim(),
                    fieldName: field.trim()
                }));
            })
            .catch(error => {
                this.error = error;
                this.results = undefined;
            });
    }
}