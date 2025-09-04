public class ParkLocator {
    
    public static String[] country(String cou){
        String[] res;
        ParkService.ParksImplPort parkServiceInstance = new ParkService.ParksImplPort();
        res =parkServiceInstance.byCountry(cou);
        System.debug('Germany Information :'+res);
        return res;
    }

}