trigger PropertyTrigger on Property__c (Before insert, Before update, Before delete, After insert, After update,After delete, After unDelete) {
  
  
  if(Trigger.isInsert && Trigger.isBefore){  
    PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'before');
    PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'before');

    
  }else if(Trigger.isUpdate && Trigger.isBefore){
    if(Trigger.old != Trigger.new){
        PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'before');
        PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'before');

    }

  }else if(Trigger.isDelete && Trigger.isBefore){
    PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'before');
    PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'before');

  }else if(Trigger.isInsert && Trigger.isAfter){
  
    PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'after');
    PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'after');

  }else if(Trigger.isUpdate && Trigger.isAfter){
  
    if(Trigger.old != Trigger.new){
        PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'after');
        PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'after');

    }

  }else if(Trigger.isDelete && Trigger.isAfter){
  
    PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'after');
    PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'after');

  }else if(Trigger.isUndelete && Trigger.isAfter){
  
    PropertyApexClass.displayLatestVersionOfRecords(Trigger.new,Trigger.newMap,'after');
    PropertyApexClass.displayOldVersionOfRecords(Trigger.old,Trigger.oldMap,'after');

  }
  
}