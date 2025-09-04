import { LightningElement,api } from 'lwc';

export default class ChildCompo2 extends LightningElement {

    @api childcomponame = "childCompo2";
    @api info = "I am giving the discount";

    FireEventHandler(event){
        const evt = new CustomEvent('mycustomevent', {
            detail:
            {
                childcomponame:this.childcomponame,
                info:this.info
            }
        });
        this.dispatchEvent(evt);
    }
}