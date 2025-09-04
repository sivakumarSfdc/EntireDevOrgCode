@isTest
public class TestVerifyDate {
    
    @isTest
    public static void checkDate (){
        Test.startTest();
        Date startDate = date.newInstance(2015, 12, 15);
        Date endDate = date.newInstance(2015, 12, 16);
        Date method1res1 = VerifyDate.CheckDates(startDate, endDate);
        System.assertEquals(endDate, method1res1);
        
        Date varStartDate = date.newInstance(2015, 12, 17);
        Date varEndDate = date.newInstance(2015, 12, 16);
        Date method1res = VerifyDate.CheckDates(varStartDate, varEndDate);
        System.assertEquals(date.newInstance(2015, 12, 31), method1res);


        Test.stopTest();
    }

}