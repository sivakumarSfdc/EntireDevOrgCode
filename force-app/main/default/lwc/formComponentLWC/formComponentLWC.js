import { LightningElement } from 'lwc';

export default class FormComponentLWC extends LightningElement {
    isShowForum = false;
    ShowFormHandler(event){
        this.isShowForum =true;
    }
    HideFormHandler(event){
        this.isShowForum =false;

    }
}