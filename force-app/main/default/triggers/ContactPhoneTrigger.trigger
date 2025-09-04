trigger ContactPhoneTrigger on Contact (Before Insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        ContactPhoneController2.contactUpdate(Trigger.new);
    }

}