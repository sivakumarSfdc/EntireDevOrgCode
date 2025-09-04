import { LightningElement, api } from 'lwc';

export default class ChildComponentScenario extends LightningElement {
    @api messagefromparentcompo;
    @api projectcode;
}