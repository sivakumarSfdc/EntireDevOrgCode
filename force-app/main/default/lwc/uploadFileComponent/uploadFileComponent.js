import { LightningElement,api } from 'lwc';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class UploadFileComponent extends LightningElement {

    @api 
    recordId;
    get acceptedFormats(){
        return ['.txt','.pdf','.jpeg'];
    }

    handleUploadFinished(event){
        const uploadedFiles = event.detail.files;
        let UploadedFileNames = '';
        for(let i=0;i<uploadedFiles.length;i++){
            UploadedFileNames = UploadedFileNames + uploadedFiles[i].name+', ';
        }
        this.dispatchEvent(
            new ShowToastEvent({
                title:'success',
                message:uploadedFiles.length+' Files uploaded successfully: '+ UploadedFileNames,
                variant:'success'
            }),
        );
    }
}