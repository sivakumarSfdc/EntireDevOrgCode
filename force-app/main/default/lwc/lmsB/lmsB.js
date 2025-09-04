import { LightningElement, wire } from 'lwc';
import msgService from '@salesforce/messageChannel/exploringLMS__c';
import { unsubscribe, subscribe, MessageContext, APPLICATION_SCOPE} from 'lightning/messageService';

export default class LmsB extends LightningElement {
    messageReceived ='';
    subscription;

    @wire(MessageContext)
    messageContext;

    handleMessage(message){
        this.messageReceived = message.recordData ? message.recordData : 'No data received';
    }

    connectedCallback(){
        if(!this.subscription){
            this.subscription = subscribe(
                this.messageContext,
                msgService,
                (message) => {
                    this.handleMessage(message);
                },
                { scope: APPLICATION_SCOPE }
            );
        }
        }

    subscribeHandler(){
        if(!this.subscription){
            this.subscription = subscribe(
                this.messageContext,
                msgService,
                (message) => {
                    this.handleMessage(message);
                },
                { scope: APPLICATION_SCOPE }
            );
        }
    }
    unSubscribeHandler(){
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}