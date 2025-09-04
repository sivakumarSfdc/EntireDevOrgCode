public class FlowErrorThrower {
    @InvocableMethod(label='Throw Error' description='Throw error to stop login')
    public static void throwError(List<String> messages){
        throw new FlowException(messages[0]);
    }
}