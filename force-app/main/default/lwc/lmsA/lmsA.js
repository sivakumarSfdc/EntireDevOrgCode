import { LightningElement, wire } from 'lwc';
import msgService from "@salesforce/messageChannel/exploringLMS__c";
import { publish, MessageContext } from "lightning/messageService";

export default class LmsA extends LightningElement {
    @wire (MessageContext)
    messageContext;

    inputMessage='';
    handleNameChange(event){
        this.inputMessage = event.target.value;
    }
    publishHandler(){
      const message= {
        recordData: this.inputMessage
      }
      publish(this.messageContext,msgService,message);
    }
}