public class EmployeeAPICallout {
    
    public static void callEmployeeAPI(){
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:RestAPI/api/v1/employees');
        req.setMethod('GET');
        HttpResponse response= htp.send(req);
        String responseFromAPI = response.getBody();
        System.debug('ResponseFromApi >>>>>>>>>>>>:'+responseFromAPI);
    }

}