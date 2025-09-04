import { LightningElement } from 'lwc';

export default class JsToHtmlComponent extends LightningElement {
    UserName = 'Siva Kumar';
    HandlerChangeName(event){
        this.UserName ='Rajesh varma';
    }
}