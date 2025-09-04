@isTest
public class AnimalLocatorTest {
    
    @isTest 
    static  void testGetCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 

        String result = AnimalLocator.getAnimalNameById(1);
        String expectedValue = 'CHICK';
        System.assertEquals(expectedValue, result,'not matched with name');

    }   


}