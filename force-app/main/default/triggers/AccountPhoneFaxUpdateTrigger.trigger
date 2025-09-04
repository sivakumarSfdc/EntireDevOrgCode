trigger AccountPhoneFaxUpdateTrigger on Account (After update) {

  if(Trigger.isUpdate && Trigger.isAfter){
  if(System.label.Deactivate_Trigger == 'true'){
return;
}

  
     AccountPhoneFaxUpdateClass.updateChildRecords(Trigger.new, Trigger.oldMap);
  }

}