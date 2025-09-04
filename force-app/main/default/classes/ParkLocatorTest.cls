@isTest
public class ParkLocatorTest {
 @isTest
    public static void Method1(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] actualValue = ParkLocator.country('India');
        String[] expectedVale =new String[]{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'};
        System.assertEquals(expectedVale,actualValue, 'not matched');
    }   
}