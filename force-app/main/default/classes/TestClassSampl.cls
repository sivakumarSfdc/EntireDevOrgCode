@isTEST
public class TestClassSampl{



@isTest
public static void TestMethod1(){


Test.startTest();
  Opportunity op = new Opportunity();
  op.Name = 'TestOpp';
  op.CloseDate = Date.today();
  op.StageName='Qualification';
  insert op;
  Student__c st = new Student__c();
  st.Opportunity__c = op.Id;
  st.Chemistry__c = 10;
  st.Physics__c =10;
  st.Maths__c = 10;
  st.Name = 'Test Name';
  st.Email__c ='Test@gmail.com';
  insert st;  
  
  op.Name = 'TestOpp1';
  update op;

Test.stopTest();
}



}