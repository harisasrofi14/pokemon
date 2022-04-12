import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/presentation/pages/detail_screen.dart';
import 'package:pokemon/presentation/widgets/type_container.dart';

class CardPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const CardPokemon(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var img = pokemon.image;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailScreen.ROUTE_NAME,
          arguments: pokemon,
        );
      },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    pokemon.number,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                child: CachedNetworkImage(
                  width: 70,
                  height: 70,
                  imageUrl: img,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )),
                  ),
                  fit: BoxFit.scaleDown,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pokemon.types.length,
                    itemBuilder: (context, index) {
                      return TypeContainer(pokemon.types[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
