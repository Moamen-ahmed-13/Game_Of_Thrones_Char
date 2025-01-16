import 'package:breaking_bad_char/data/model.dart';
import 'package:breaking_bad_char/data/web_service.dart';

class CharacterRepository {
  final CharactersWebServices charactersWebServices;

  CharacterRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character)=> Character.fromJson(character)).toList();
  }
}
