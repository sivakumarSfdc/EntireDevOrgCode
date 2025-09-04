trigger AccountAddressTrigger on Account (Before insert, Before update) {

   if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
if(System.label.Deactivate_Trigger == 'true'){
return;
}

       for(Account varAccRec: Trigger.new){
        
          if(varAccRec.Match_Billing_Address__c == True){
          
            varAccRec.ShippingPostalCode = varAccRec.BillingPostalCode;
          }
        
       }
      
      
   }

}