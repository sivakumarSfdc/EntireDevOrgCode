public class testClass2{


    private ApexPages.StandardController controller;
    public testClass2(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    public PageReference redirect(){
    
      
      PageReference pg;
      if(false){
      
       pg = new PageReference ('/apex/Test2vfp1?id='+controller.getRecord().Id);
             pg.setRedirect(true);

       
      }else{
      
        /* pg = new ApexPages.StandardController(controller.getRecord()).edit();
               System.debug('Test Data exe');
               
                String recordId =            String.valueof(controller.getRecord().Id).substring(0,15);

              String detailPageUrl = '/'+recordId;
              String editPageUrl = '/'+recordId +'/e?retURL='+EncodingUtil.urlEncode(detailPageUrl ,'UTF-8');
        
         pg = new PageReference (editPageUrl );
         pg.setRedirect(true);
                        System.debug('Test Data exe -'+controller.getRecord().Id);*/
                                        String recordId =            String.valueof(controller.getRecord().Id).substring(0,15);

                                      String detailPageUrl = '/'+recordId;

             string editurl =new ApexPages.StandardController(controller.getRecord()).edit().getUrl()+'?retURL='+EncodingUtil.urlEncode(detailPageUrl ,'UTF-8');           
                              pg = new PageReference (editurl);
   
                       pg.setRedirect(true);
          


      }
              return pg;

    }

}