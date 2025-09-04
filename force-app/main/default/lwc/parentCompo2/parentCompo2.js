import { LightningElement } from 'lwc';

export default class ParentCompo2 extends LightningElement {

    ChildEventHandler(event){
        alert('I am Handling the child event');
        const name = event.detail.childcomponame;
        const information = event.detail.info;
        alert('name ='+name);
        alert('information ='+information);


    }
}