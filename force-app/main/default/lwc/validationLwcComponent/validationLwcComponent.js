import { LightningElement } from 'lwc';

export default class ValidationLwcComponent extends LightningElement {

    ValidationHandler(event){
        let nameCompoRef = this.template.querySelector(".namecomp");
        let dateCompoRef = this.template.querySelector(".datecompo");
        
        let nameCompoValue = nameCompoRef.value.trimStart();
        let datCompoValue = dateCompoRef.value;

        if(!nameCompoValue){
            nameCompoRef.setCustomValidity('Name is required');
        }else{
            nameCompoRef.setCustomValidity('');
         }
         nameCompoRef.reportValidity();

        if(!datCompoValue){
            dateCompoRef.setCustomValidity('Date is required');
        }else{
            dateCompoRef.setCustomValidity('');
         }
         dateCompoRef.reportValidity();

    }
}