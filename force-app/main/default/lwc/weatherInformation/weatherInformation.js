import { LightningElement } from 'lwc';
import getWeatherDetails from '@salesforce/apex/SendWeatherReq.GetWeatherDetails'
export default class WeatherInformation extends LightningElement {
		inputCityName = '';
		weatherDetails ={};
		showWeatherDetails = false;
		
		handleInputChange(event){
				this.inputCityName = event.detail.value;
		}
		
		handleWeatherDetails(){
				getWeatherDetails({cityName : this.inputCityName})
				.then((result) => {
                    if (result && Object.keys(result).length > 0) {
                        this.showWeatherDetails = true;
                        this.weatherDetails = result;
                    } else {
                        this.showWeatherDetails = false;
                        console.log('No weather details found or result is empty.');
                    }
                })
				.catch((error) =>{
						this.showWeatherDetails = false;
						console.log('Some error occurred while fetching weather details');
				});
				console.log('result '+JSON.stringify(this.weatherDetails));
		}
		
}