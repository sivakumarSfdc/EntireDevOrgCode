public class MapdataApexClass {
    @AuraEnabled
    public static Map<String,List<String>> getMapData(){
            Map<String,List<String>> mapObject = new Map<String,List<String>>();
            List<String> IndiaList = new List<String>{'Mumbai','pune','delhi'};
            List<String> USAList = new List<String>{'NewYork','NewJersey','Washington DC'};
            List<String> AustrilaList = new List<String>{'Canbera','perth','sydney'};
            mapObject.put('India',IndiaList);
            mapObject.put('USA',USAList);
            mapObject.put('Austrila',AustrilaList);
            return mapObject;
    }
}