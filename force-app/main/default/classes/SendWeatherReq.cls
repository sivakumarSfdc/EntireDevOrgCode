public with sharing class SendWeatherReq {
    @AuraEnabled
    public static WeatherInformation GetWeatherDetails(String cityName){
        final String API_Key = '228781f0d2da3b4db40a43fe442da4b7';
        String endPoint = 'https://api.openweathermap.org/data/2.5/weather';
        endPoint += '?q=' + EncodingUtil.urlEncode(cityName, 'UTF-8');
        endPoint += '&units=metric';
        endPoint += '&APPID=' + API_Key;
        System.debug('URL: ' + endPoint);
        
        WeatherInformation weatherInformation = new WeatherInformation();
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        
        try {
            HttpResponse res = http.send(req);
            System.debug('Response: ' + res.getBody());
            if (res.getStatusCode() == 200) {
                JsonWeatherParser jsonWeatherParser = JsonWeatherParser.parse(res.getBody());
                System.debug('jsonWeatherParser: ' + jsonWeatherParser);
                weatherInformation.city = String.valueOf(jsonWeatherParser.name);
                weatherInformation.temprature = String.valueOf(jsonWeatherParser.main.temp);
                weatherInformation.pressure = String.valueOf(jsonWeatherParser.main.pressure);
                weatherInformation.humidity = String.valueOf(jsonWeatherParser.main.humidity);
                weatherInformation.feelsLike = String.valueOf(jsonWeatherParser.main.feels_like);
                weatherInformation.tempMin = String.valueOf(jsonWeatherParser.main.temp_min);
                weatherInformation.tempMax = String.valueOf(jsonWeatherParser.main.temp_max);

            } else {
                System.debug('Error: ' + res.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
        System.debug('weatherInformation: ' + weatherInformation);
        return weatherInformation;
    }
    public class WeatherInformation{
        @AuraEnabled public String city {get; set;}
        @AuraEnabled public String temprature {get; set;}
        @AuraEnabled public String pressure {get; set;}
        @AuraEnabled public String humidity {get; set;}
        @AuraEnabled public String feelsLike {get; set;}
        @AuraEnabled public String tempMin {get; set;}
        @AuraEnabled public String tempMax {get; set;}

    }
}