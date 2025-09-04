import { LightningElement } from 'lwc';

export default class HtmlToJsComponent extends LightningElement {
    textHandler(event){
        var VarWeGotValueFromHtml = event.target.value;
        alert('Entered value is :'+VarWeGotValueFromHtml);
    }
}