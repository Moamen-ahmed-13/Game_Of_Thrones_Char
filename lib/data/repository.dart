import 'package:game_of_thrones_char/data/models/character.dart';
import 'package:game_of_thrones_char/data/web_service.dart';

class CharacterRepository {
  final CharactersWebServices charactersWebServices;

  CharacterRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character)=> Character.fromJson(character)).toList();
  }
}
