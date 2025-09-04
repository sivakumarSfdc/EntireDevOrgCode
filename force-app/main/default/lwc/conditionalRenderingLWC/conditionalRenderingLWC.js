import { LightningElement } from 'lwc';
import KarizmaImageReference from '@salesforce/resourceUrl/karizmaRBikeImage';
import SafariImageReference from '@salesforce/resourceUrl/safariDicorImage' ;
import WelcomeLabelReference from '@salesforce/label/c.WelcomeLabel';
import ShowCarLabelReference from '@salesforce/label/c.ShowCarLabel';
import ShowBikeLabelReference from '@salesforce/label/c.ShowBikeLabel';
export default class ConditionalRenderingLWC extends LightningElement {
    showImage = KarizmaImageReference ;
    isShowBike = true;
    listLabel ={WelcomeLabelReference,
                ShowCarLabelReference,
                ShowBikeLabelReference};
    ShowCarHandler(event){
        if(this.isShowBike === true){
            this.showImage = SafariImageReference;
            this.isShowBike = false;
        }else{
            this.showImage = KarizmaImageReference ;
            this.isShowBike = true;
        }
    }
}