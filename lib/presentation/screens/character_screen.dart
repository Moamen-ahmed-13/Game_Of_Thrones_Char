import 'package:breaking_bad_char/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/character_cubit.dart';
import '../../data/model.dart';
import '../widgets/character_card.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCharacters = BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: [
          buildCharactersList(),
        ]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 5,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchController.text.isEmpty
          ? allCharacters.length
          : searchedCharacters.length,
      itemBuilder: (context, index) {
        return CharacterCard(
          character: searchController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        );
      },
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Search for a character...',
        border: InputBorder.none,
        suffixStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (value) {
        addSearchedForCharactersToSearchedList(value);
      },
    );
  }

  void addSearchedForCharactersToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where(
          (character) => character.name.toLowerCase().contains(
                searchedCharacter.toLowerCase(),
              ),
        )
        .toList();

    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear),
          color: Color.fromARGB(172, 225, 232, 235),
          iconSize: 30,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: Icon(Icons.search),
          color: Color.fromARGB(172, 225, 232, 235),
          iconSize: 30,
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: const Text('Characters',
          style: TextStyle(
              color: Color.fromARGB(172, 225, 232, 235),
              fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: isSearching ? Container() : null,
        actions: buildAppBarActions(),
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: buildBlocWidget()),
    );
  }
}
