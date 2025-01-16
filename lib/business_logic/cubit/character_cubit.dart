import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/model.dart';
import '../../data/repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  late List<Character> characters = [];

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
