import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/injection.dart' as di;
import 'package:pokemon/presentation/bloc/filter/filter_bloc.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon/presentation/pages/detail_screen.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<PokemonBloc>()),
        BlocProvider(create: (_) => di.locator<FilterBloc>())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomeScreen.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              case DetailScreen.ROUTE_NAME:
                final pokemon = settings.arguments as Pokemon;
                return MaterialPageRoute(
                  builder: (_) => DetailScreen(pokemon: pokemon),
                  settings: settings,
                );
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          }),
    );
  }
}
