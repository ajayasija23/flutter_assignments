import 'package:dio/dio.dart';
import 'package:emojis_demo/models/PokemonData.dart';
class ApiHelper{
  final dio = Dio();
  final String baseUrl="https://pokeapi.co/api/v2/pokemon";

  Future<PokemonData?> fetchPokeMons() async {
    final params= Map<String,String>();
    params["offset"]="0";
    params["limit"]="20";
    final  response = await dio.get(baseUrl,queryParameters: params);
    print(response.data);
    return PokemonData.fromJson(response.data);
  }
}