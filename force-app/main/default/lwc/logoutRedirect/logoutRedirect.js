// logoutRedirect.js
import { LightningElement } from 'lwc';

export default class LogoutRedirect extends LightningElement {
    connectedCallback() {
        // Redirect user to Salesforce logout page
        window.location.href = '/secur/logout.jsp';
    }
}