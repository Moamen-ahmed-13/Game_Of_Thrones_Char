import 'package:game_of_thrones_char/constants/strings.dart';
import 'package:game_of_thrones_char/data/repository.dart';
import 'package:game_of_thrones_char/data/web_service.dart';
import 'package:game_of_thrones_char/presentation/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'business_logic/cubit/character_cubit.dart';
import 'data/models/character.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharacterCubit characterCubit;
  late CharacterRepository characterRepository;

  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebServices());
    characterCubit = CharacterCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterCubit,
            child: CharacterScreen(),
          ),
        );

      case characterDetailsScreen: 
      final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
    }
   
  }
}
