public with sharing class MonthApexClass {

    public static void displayMonths(){
        Map<Integer, String> mpOfMonths = new Map<Integer, String>{
            1 => 'Jan',
            2 => 'Feb',
            3 => 'Mar',
            4 => 'Apr',
            5 => 'May',
            6 => 'June',
            7 => 'July',
            8 => 'Aug',
            9 => 'Sep',
            10 => 'Oct',
            11 => 'Nov',
            12 => 'Dec'
        };
        System.debug('>>>MpOfMonths>>>>>>>>>>'+mpOfMonths);
        Map<Integer, String> mpOfTerms = new Map<Integer, String>{
   
            1 => 'st',
            2 => 'nd',
            3 => 'rd',
            21 => 'st',
            22 => 'nd',
            23 => 'rd',
            31 => 'st'
         };
         System.debug('>>>mpOfTerms>>>>>>>>>>'+mpOfTerms);
         System.debug('>>>>>>mpOfmonthsKeySet>>>>>>>>'+mpOfMonths.keySet());
        for(Integer num: mpOfMonths.keySet()){
            for(Integer i=1; i<= Date.daysInMonth(Date.today().year(), num); i++){
                 if(mpOfTerms.containsKey(i)){
                    System.debug( i+' '+mpOfTerms.get(i)+' '+mpOfMonths.get(num)+' '+ Date.today().year());
                 }else{
                    System.debug( i+' '+'th'+' '+mpOfMonths.get(num)+' '+ Date.today().year());

                 }
            }

        }

    }
}