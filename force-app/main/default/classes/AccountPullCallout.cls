public with sharing Class AccountPullCallout{
  
  public static void SendAccounts(List<Account> lsOfAccounts){
    
    String requestBody = JSON.serialize(lsOfAccounts);
    String target_EndPoint = 'callout:SalesforceNamedCred/services/apexrest/AccountInt';
    
    HttpRequest req = new HttpRequest();
    req.setEndpoint(target_EndPoint);
    req.setMethod('POST');
    req.setHeader('Authorization', 'Bearer' + UserInfo.getSessionId());
    req.setHeader('Content-Type', 'application/json');
    System.debug('accountJson>>>>>>>>'+requestBody);
    req.setBody(requestBody);
    
    Http http = new Http();
    HttpResponse res = http.send(req);
    if(res.getStatusCode() != 200){
        System.debug('Error sending Accounts >>>>>>>>>'+res.getBody());
    }else{
        System.debug('Account sent successfully >>>>>>>>>'+res.getBody());    
    }
  
  }

}