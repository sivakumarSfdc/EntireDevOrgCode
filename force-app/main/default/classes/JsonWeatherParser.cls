public class JsonWeatherParser {
	public cls_coord coord;
	public cls_weather[] weather;
	public String base;	//stations
	public cls_main main;
	public Integer visibility;	//10000
	public cls_wind wind;
	public cls_rain rain;
	public cls_clouds clouds;
	public Integer dt;	//1715927030
	public cls_sys sys;
	public Integer timezone;	//19800
	public Integer id;	//1270668
	public String name;	//Guntur
	public Integer cod;	//200
	class cls_coord {
		public Double lon;	//80.45
		public Double lat;	//16.3
	}
	class cls_weather {
		public Integer id;	//501
		public String main;	//Rain
		public String description;	//moderate rain
		public String icon;	//10d
	}
	public class cls_main {
		public Double temp;	//27.04
		public Double feels_like;	//29.36
		public Double temp_min;	//27.04
		public Double temp_max;	//27.94
		public Integer pressure;	//1009
		public Integer humidity;	//75
		public Integer sea_level;	//1009
		public Integer grnd_level;	//1006
	}
	class cls_wind {
		public Double speed;	//4.17
		public Integer deg;	//95
		public Double gust;	//5.71
	}
	class cls_rain {
		public Double h;	//2.66
	}
	class cls_clouds {
		public Integer all;	//100
	}
	class cls_sys {
		public Integer type;	//2
		public Integer id;	//2083890
		public String country;	//IN
		public Integer sunrise;	//1715904444
		public Integer sunset;	//1715950921
	}
	public static JsonWeatherParser parse(String json){
		return (JsonWeatherParser) System.JSON.deserialize(json, JsonWeatherParser.class);
	}
}