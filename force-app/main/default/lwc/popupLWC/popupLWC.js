// popupLwc.js
import { LightningElement, api } from 'lwc';

export default class PopupLwc extends LightningElement {
    @api message;
    @api vfCallback; // ✅ declare API property

    handleClose() {
        console.log('Closing popup...');
        if (typeof this.vfCallback === 'function') {
            try {
                this.vfCallback(); // ✅ safely call
            } catch (err) {
                console.error('Error calling VF callback:', err);
            }
        } else {
            console.warn('VF callback not provided or not a function');
        }
    }

    disconnectedCallback() {
        console.log('PopupLwc disconnected');
    }
}