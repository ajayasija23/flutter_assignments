import 'package:dio/dio.dart';
import 'package:emojis_demo/models/WeatherData.dart';
class ApiHelper{
  final dio = Dio();
  final String baseUrl="https://api.weatherapi.com/v1/forecast.json";
  final String apiKey="a1ea999f036048fe8ed124722250809";

  Future<WeatherData?> fetchWeather(Map<String,Object> params) async {
    params["key"]=apiKey;
    final  response = await dio.get(baseUrl,queryParameters: params);
    print(response.data);
    return WeatherData.fromJson(response.data);
  }
}