/*
 Created By: Siva kumar
 Date : 25/06/2024
 Application: This class is used to manage expenses coming from FormerCorner vfp 
*/

public without sharing class ExpenceController{

    @RemoteAction
    public static void ManageExpence(String farmerName, String phone, String vDate, Map<String, Decimal> expenseMap, String email, Decimal earned) {
        // Extract the date part from the datetime string
        String dateString = vDate.split(' ')[0];
        
        Date fDate;
        try {
            fDate = Date.valueOf(dateString);
        } catch (Exception e) {
            System.debug('Error converting string to date: ' + e.getMessage());
            return;
        }

        System.debug('FarmerName: ' + farmerName);
        System.debug('Phone: ' + phone);
        System.debug('Date: ' + fDate);
        System.debug('ExpenseMap: ' + expenseMap);
        System.debug('EarnedAmount: ' + earned);


        List<sObject> newExpenses = new List<sObject>();

        List<AgriFarmer__c> farmers = [SELECT Id, Name, Mobile__c, Date__c, Email__c, Earned__c,
                                        (SELECT Id, AgriFarmer__c, PastExpence__c, PresentExpence__c FROM SeedsExpences__r),
                                        (SELECT Id, AgriFarmer__c, PastExpence__c, PresentExpence__c FROM TractorExpences__r),
                                        (SELECT Id, AgriFarmer__c, PastExpence__c, PresentExpence__c FROM LabourExpences__r),
                                        (SELECT Id, AgriFarmer__c, PastExpence__c, PresentExpence__c FROM PesticideExpences__r)
                                        FROM AgriFarmer__c WHERE Mobile__c = :phone];

        if (farmers.size() > 0) {
            verifyExpense(farmers, expenseMap, fDate, email, earned);
        } else {
            AgriFarmer__c farmer = new AgriFarmer__c(Name = farmerName, Mobile__c = phone, Date__c = fDate, Email__c = email,
             CurrencyIsoCode= 'INR', Earned__c = earned);
            insert farmer;

            for (String key : expenseMap.keySet()) {
                if (key == 'seeds') {
                    SeedsExpence__c se = new SeedsExpence__c();
                    se.AgriFarmer__c = farmer.Id;
                    se.PastExpence__c = 0;
                    se.PresentExpence__c = expenseMap.get(key);
                    se.CurrencyIsoCode= 'INR';
                    newExpenses.add(se);
                } else if (key == 'tractor') {
                    TractorExpence__c te = new TractorExpence__c();
                    te.AgriFarmer__c = farmer.Id;
                    te.PastExpence__c = 0;
                    te.PresentExpence__c = expenseMap.get(key);
                    te.CurrencyIsoCode= 'INR';
                    newExpenses.add(te);
                } else if (key == 'labour') {
                    LabourExpence__c le = new LabourExpence__c();
                    le.AgriFarmer__c = farmer.Id;
                    le.PastExpence__c = 0;
                    le.PresentExpence__c = expenseMap.get(key);
                    le.CurrencyIsoCode= 'INR';
                    newExpenses.add(le);
                } else if (key == 'pesticides') {
                    PesticideExpence__c pe = new PesticideExpence__c();
                    pe.AgriFarmer__c = farmer.Id;
                    pe.PastExpence__c = 0;
                    pe.PresentExpence__c = expenseMap.get(key);
                    pe.CurrencyIsoCode= 'INR';
                    newExpenses.add(pe);
                }
            }
            if (newExpenses.size() > 0) {
                insert newExpenses;
            }
        }
    }

    public static void verifyExpense(List<AgriFarmer__c> farmers, Map<String, Decimal> expenseMap, Date vdate, String email, Decimal earned) {
        List<sObject> upsertExpenses = new List<sObject>();
        
        AgriFarmer__c farmer = farmers[0];
        if(farmer.Date__c != vdate || farmer.Email__c != email || earned > 0){
            if(farmer.Date__c != vdate){                     
               farmer.Date__c = vdate;
            }
            if(farmer.Email__c != email){
               farmer.Email__c = email;
            }
            System.debug('farmer.Earned__c :'+farmer.Earned__c);
            farmer.Earned__c += earned;
          upsertExpenses.add(farmer);
        }

        if (farmer.SeedsExpences__r.size() > 0 && expenseMap.containsKey('seeds')) {
            SeedsExpence__c se = farmer.SeedsExpences__r[0];
            se.PastExpence__c = se.PresentExpence__c;
            se.PresentExpence__c += expenseMap.get('seeds');
            upsertExpenses.add(se);
        } else if (expenseMap.containsKey('seeds')) {
            SeedsExpence__c se = new SeedsExpence__c();
            se.AgriFarmer__c = farmer.Id;
            se.PastExpence__c = 0;
            se.PresentExpence__c = expenseMap.get('seeds');
            upsertExpenses.add(se);
        }

        if (farmer.TractorExpences__r.size() > 0 && expenseMap.containsKey('tractor')) {
            TractorExpence__c te = farmer.TractorExpences__r[0];
            te.PastExpence__c = te.PresentExpence__c;
            te.PresentExpence__c += expenseMap.get('tractor');
            upsertExpenses.add(te);
        } else if (expenseMap.containsKey('tractor')) {
            TractorExpence__c te = new TractorExpence__c();
            te.AgriFarmer__c = farmer.Id;
            te.PastExpence__c = 0;
            te.PresentExpence__c = expenseMap.get('tractor');
            upsertExpenses.add(te);
        }

        if (farmer.LabourExpences__r.size() > 0 && expenseMap.containsKey('labour')) {
            LabourExpence__c le = farmer.LabourExpences__r[0];
            le.PastExpence__c = le.PresentExpence__c;
            le.PresentExpence__c += expenseMap.get('labour');
            upsertExpenses.add(le);
        } else if (expenseMap.containsKey('labour')) {
            LabourExpence__c le = new LabourExpence__c();
            le.AgriFarmer__c = farmer.Id;
            le.PastExpence__c = 0;
            le.PresentExpence__c = expenseMap.get('labour');
            upsertExpenses.add(le);
        }

        if (farmer.PesticideExpences__r.size() > 0 && expenseMap.containsKey('pesticides')) {
            PesticideExpence__c pe = farmer.PesticideExpences__r[0];
            pe.PastExpence__c = pe.PresentExpence__c;
            pe.PresentExpence__c += expenseMap.get('pesticides');
            upsertExpenses.add(pe);
        } else if (expenseMap.containsKey('pesticides')) {
            PesticideExpence__c pe = new PesticideExpence__c();
            pe.AgriFarmer__c = farmer.Id;
            pe.PastExpence__c = 0;
            pe.PresentExpence__c = expenseMap.get('pesticides');
            upsertExpenses.add(pe);
        }

        if (upsertExpenses.size() > 0) {
            upsert upsertExpenses;
        }
    }
}