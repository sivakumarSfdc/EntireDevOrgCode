public class TestAlertController {
    public String type {get; set;}
    public String message {get; set;}
    public Boolean showPopup {get; set;}
    
    public TestAlertController() {
        showPopup = false;
    }

    public void submit() {
       showPopup = true;

    }
}