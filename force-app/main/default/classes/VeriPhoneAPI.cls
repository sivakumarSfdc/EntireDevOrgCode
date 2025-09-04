public class VeriPhoneAPI {

    @InvocableMethod(label ='verifyPhoneNumber' callout = 'true')
    public static List<PhoneValidationResult> verifyMobileNumber(List<InputElement> phoneNumbers) {
        final String EndPoint = 'https://api.veriphone.io/v2/verify';
        final String API_KEY = System.Label.VeriPhone_APIKEY;
        List<PhoneValidationResult> results = new List<PhoneValidationResult>();
        
        for (InputElement mNumber : phoneNumbers) {
            String URL = EndPoint + '?phone=+91' + mNumber.phoneNumber + '&key=' + API_KEY;
            System.debug('URL :' + URL);        
            Http h = new Http();       
            // HTTP Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(URL);
            req.setMethod('GET');
            req.setTimeout(60000);
            req.setHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
            req.setHeader('Accept', 'application/json');

            try {
                HttpResponse resp = h.send(req);
                if (resp.getStatusCode() == 200) {
                    PhoneValidationResult pResp = (PhoneValidationResult) System.JSON.deserialize(resp.getBody(), PhoneValidationResult.class);
                    System.debug('resp.getBody(): ' + resp.getBody());
                    results.add(pResp);
                } else {
                    System.debug('HTTP Response Code: ' + resp.getStatusCode());
                    System.debug('HTTP Response: ' + resp.getBody());
                    results.add(new PhoneValidationResult(false, 'Error: ' + resp.getBody(), mNumber.phoneNumber));
                }
            } catch (Exception e) {
                System.debug('Exception: ' + e.getMessage());
                results.add(new PhoneValidationResult(false, 'Exception: ' + e.getMessage(), mNumber.phoneNumber));
            }
        }
        return results;
    }

    public class PhoneValidationResult {
        @InvocableVariable
        public Boolean isValid;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String phoneNumber;

        @InvocableVariable
        public String status;
        
        @InvocableVariable
        public String phone;
        
        @InvocableVariable
        public Boolean phone_valid;
        
        @InvocableVariable
        public String phone_type;
        
        @InvocableVariable
        public String phone_region;
        
        @InvocableVariable
        public String country;
        
        @InvocableVariable
        public String country_code;
        
        @InvocableVariable
        public String country_prefix;
        
        @InvocableVariable
        public String international_number;
        
        @InvocableVariable
        public String local_number;
        
        @InvocableVariable
        public String e164;
        
        @InvocableVariable
        public String carrier;

        public PhoneValidationResult(Boolean isValid, String message, String phoneNumber) {
            this.isValid = isValid;
            this.message = message;
            this.phoneNumber = phoneNumber;
        }
    }

    public class InputElement {
        @InvocableVariable
        public String phoneNumber;
    }
}