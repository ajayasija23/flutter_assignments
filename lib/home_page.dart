import 'package:emojis_demo/models/PokemonData.dart';
import 'package:emojis_demo/util/api_helper.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonData? pokemonData;

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    final response = await ApiHelper().fetchPokeMons();
    setState(() {
      pokemonData= response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomePage());
  }

  Widget _buildHomePage() {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            16.h,
            Text(
              "Pokemon List",
              style: TextStyles.robotoBody.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.h,
            pokemonData==null?Center(child: CircularProgressIndicator(),):GridView.builder(
              itemBuilder: (context, item) => _buildListItem(item),
              itemCount: pokemonData?.results!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // disable GridView's scroll
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 3 items per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1, // width/height ratio
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    final item = pokemonData?.results?[index];
    final imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png";

    return RoundedImageTile(imageUrl: imageUrl, title: item?.name??"");
  }

}
