import 'package:emojis_demo/models/WeatherData.dart';
import 'package:emojis_demo/util/api_helper.dart';
import 'package:emojis_demo/util/util_functions.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';

class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpinnerController controller = SpinnerController();
  final ApiHelper apiHelper=ApiHelper();
  WeatherData? weatherData = null;

  @override
  void initState() {
    super.initState();

    fetchWeather();

  }
  void fetchWeather() async {
    final position=await UtilFunctions.determinePosition();
    dynamic params= <String,Object>{};
    params["q"]="${position.latitude},${position.longitude}";
    dynamic weatherData =await apiHelper.fetchWeather(
        params
    );
    setState(() {
      this.weatherData=weatherData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomeBody(context),
    );
  }

  Widget _buildHomeBody(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/bg_weather.png"),fit: BoxFit.fill)
      ),
      child: SafeArea(
        child: weatherData==null ? Center(child: CircularProgressIndicator()) : _showWeatherData()
      )
    );
  }

  Widget _showWeatherData() {
    return Padding(
      padding: EdgeInsets.all(16.0), // optional spacing from edges
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // aligns items inside column
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // align everything to right
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // aligns items inside column
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${weatherData!.current?.tempC} °C", style: TextStyles.robotoH1),
                        16.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("H: ${weatherData!.forecast?.forecastday![0].day?.maxtempC} °C", style: TextStyles.robotoBody),
                            Text("L: ${weatherData!.forecast?.forecastday![0].day?.mintempC} °C", style: TextStyles.robotoBody),
                          ],
                        ),
                      ],
                    ),
                    8.h,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/ic_location.svg",height: 24,fit: BoxFit.fitHeight,),
                        8.w,
                        Text("${weatherData!.location?.name}, ${weatherData!.location?.country}", style: TextStyles.robotoTitle.copyWith(fontSize: 22)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            350.h,
            Text("${weatherData!.current?.condition?.text}, Feels Like ${weatherData!.current?.feelslikeC} °C", style: TextStyles.robotoBody.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
            16.h,
            _buildForeCast()
          ],
        ),
      ),
    );
  }

  Widget _buildForeCast() {
    final forecastHours = weatherData!.forecast!.forecastday?[0].hour;
    forecastHours?.forEach((element) => print("https:${element.condition?.icon}"));
    return SizedBox(
      height: 160, // fixed height for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecastHours?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final hour = forecastHours![index];
          return Container(
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue, // border color
                width: 1,           // border width
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  UtilFunctions.formatUnixTime(hour.timeEpoch?.toInt() ?? 0),
                  style: TextStyles.robotoBody.copyWith(color: Colors.black),
                ),
                Image.network("https:${hour.condition?.icon}"),
                Text("${hour.tempC} °C", style: TextStyles.robotoBody.copyWith(color: Colors.black)),
              ],
            ),
          );
        },
      ),
    );
  }

}


