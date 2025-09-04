import { LightningElement,api } from 'lwc';

import FirstUiElement from './lifeCycleHook.html';
import SecondUiElement from './lifeCycleHook2.html';

export default class LifeCycleHook extends LightningElement {

    currentTemp = 'temp1';

    constructor(){
        super();
        console.log('CallBack Hook Constructor Called');
    }

    connectedCallback(){
        console.log('CallBack Hook connectedCallback Called');
       // throw new Error('Whoops!');

    }
    render(){
        console.log('CallBack Hook render Called');
        if(this.currentTemp === 'temp1'){
            return FirstUiElement;
        }else if(this.currentTemp === 'temp2'){
            return SecondUiElement;
        }
    }
    renderedCallback(){
        console.log('CallBack Hook renderedCallback Called');
 
    }
    disconnectedCallback(){
        console.log('CallBack Hook disconnectedCallback Called');
    }
    buttonHandler(event){
        console.log('Inside button handler');

        if(this.currentTemp === 'temp1'){
            this.currentTemp = 'temp2';
        }else{
            this.currentTemp = 'temp1'; 
        }
    }
    errorCallback(error,stack){
        console.log('Inside errorCallback ='+error);
    }
}