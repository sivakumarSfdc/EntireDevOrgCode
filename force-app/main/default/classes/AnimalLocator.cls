public class AnimalLocator {
    
    public static String getAnimalNameById( Integer varID) {//https://th-apex-http-callout.herokuapp.com/animals/<id>
        String animalName = null;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+varID);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            Map<String, Object> jsonData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animalData = (Map<String, Object>) jsonData.get('animal');
            Integer animalId = (Integer) animalData.get('id');
            animalName = (String) animalData.get('name');
            String animalEats = (String) animalData.get('eats');
            String animalSays = (String) animalData.get('says');
                System.debug(animalName);


        }

        return animalName;
    }


}