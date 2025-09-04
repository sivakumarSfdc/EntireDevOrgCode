import { LightningElement } from 'lwc';

export default class SimpleInterestLWCComponent extends LightningElement {

     VarPrincipalAmount
     VarRateOfInterest;
     VarNumberOfYears;
     Interest;
     PrincipalAmountChangeHandler(event){
        this.VarPrincipalAmount = parseInt(event.target.value);
    }
    TimeChangeHandler(event){
        this.VarNumberOfYears = parseInt(event.target.value);
    }
    InterestChangeHandler(event){
        this.VarRateOfInterest = parseInt(event.target.value);
    }
    getInterestButtonHandler(event){
        this.Interest = 'Total Interest : '+(this.VarPrincipalAmount* this.VarNumberOfYears*this.VarRateOfInterest)/100;
    }
}