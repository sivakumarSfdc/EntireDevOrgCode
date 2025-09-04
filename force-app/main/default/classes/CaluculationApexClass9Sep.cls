public class CaluculationApexClass9Sep {
    
    private static integer VarSum;
    private static integer VarMultiplcation;
    
    public static integer  getSum(integer numA, integer numB){
       VarSum = numA +numB;
       return VarSum;
    }
    
    public static void doMultiPly(integer A, integer B){
        VarMultiplcation = A*B;
        System.debug('Multiplcation : '+VarMultiplcation);
    }

}