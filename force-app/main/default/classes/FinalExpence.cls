public without sharing class FinalExpence {

    public static void updateFinalExp(Map<Id, sObject> newMap) {
        // Map to store AgriFarmer__c Ids with their associated expense records
        Map<Id, List<sObject>> mpOfAgriFarmers = new Map<Id, List<sObject>>();

        // Iterate through the newMap to populate the mpOfAgriFarmers map
        for (Id key : newMap.keySet()) {
            sObject newRecord = newMap.get(key);
            Schema.SObjectType sObjectType = newRecord.getSObjectType();

            if (sObjectType == SeedsExpence__c.sObjectType || sObjectType == TractorExpence__c.sObjectType ||
                sObjectType == LabourExpence__c.sObjectType || sObjectType == PesticideExpence__c.sObjectType) {

                Id farmerId;
                if (sObjectType == SeedsExpence__c.sObjectType) {
                    farmerId = ((SeedsExpence__c)newRecord).AgriFarmer__c;
                } else if (sObjectType == TractorExpence__c.sObjectType) {
                    farmerId = ((TractorExpence__c)newRecord).AgriFarmer__c;
                } else if (sObjectType == LabourExpence__c.sObjectType) {
                    farmerId = ((LabourExpence__c)newRecord).AgriFarmer__c;
                } else if (sObjectType == PesticideExpence__c.sObjectType) {
                    farmerId = ((PesticideExpence__c)newRecord).AgriFarmer__c;
                }

                if (mpOfAgriFarmers.containsKey(farmerId)) {
                    mpOfAgriFarmers.get(farmerId).add(newRecord);
                } else {
                    mpOfAgriFarmers.put(farmerId, new List<sObject>{newRecord});
                }
            }
        }

        // List to store AgriFarmer__c records to be updated
        List<AgriFarmer__c> ls2update = new List<AgriFarmer__c>();

        // Query for AgriFarmer__c records based on the collected Ids in mpOfAgriFarmers
        for (AgriFarmer__c agriRec : [SELECT Id, Final_Expenditure__c FROM AgriFarmer__c WHERE Id IN :mpOfAgriFarmers.keySet()]) {
            List<sObject> lsRec = mpOfAgriFarmers.get(agriRec.Id);

            for (sObject rec : lsRec) {
                Schema.SObjectType sObjectType = rec.getSObjectType();
                Decimal difference = 0;

                if (sObjectType == SeedsExpence__c.sObjectType) {
                    SeedsExpence__c expRec = (SeedsExpence__c)rec;
                    difference = expRec.PresentExpence__c - expRec.PastExpence__c;
                } else if (sObjectType == TractorExpence__c.sObjectType) {
                    TractorExpence__c expRec = (TractorExpence__c)rec;
                    difference = expRec.PresentExpence__c - expRec.PastExpence__c;
                } else if (sObjectType == LabourExpence__c.sObjectType) {
                    LabourExpence__c expRec = (LabourExpence__c)rec;
                    difference = expRec.PresentExpence__c - expRec.PastExpence__c;
                } else if (sObjectType == PesticideExpence__c.sObjectType) {
                    PesticideExpence__c expRec = (PesticideExpence__c)rec;
                    difference = expRec.PresentExpence__c - expRec.PastExpence__c;
                }
                System.debug('Difference :'+difference);
                System.debug('Final_Expenditure__c :'+agriRec.Final_Expenditure__c );

                agriRec.Final_Expenditure__c += difference;
            }

            ls2update.add(agriRec);
        }

        // Update the AgriFarmer__c records if there are any changes
        if (!ls2update.isEmpty()) {
            update ls2update;
        }
    }
}