import { LightningElement } from 'lwc';

export default class TabsetInLwc extends LightningElement {
    varTabOneBool;
    varTabTwoBool;
    hanlderEvent(event){
        let buttonClicked = event.target.label;
        switch(buttonClicked){
            case 'showCashlessInfo' :
                this.varTabOneBool =true;
                break;
            case 'showReumersimentInfo' :
                this.varTabTwoBool = true;
                break;
            case 'hideCashlessInfo' :
                this.varTabOneBool = false;
                break;
            case 'hideReumbersimentInfo' :
                this.varTabTwoBool = false;
                break;
        

        }
    }
}