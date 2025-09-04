@RestResource(urlMapping = '/sfaccounts')
global class SFAccountAPI {
    @httppost
    global static String sendAccountsList(){
        List<Account> accountList = [SELECT id, name, website FROM Account];
        String jsonData = JSON.serialize(accountList);
        System.debug('jsonData>>>>>> :'+jsonData);
        return jsonData;
    }
}