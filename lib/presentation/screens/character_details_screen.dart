import 'package:game_of_thrones_char/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character character;

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: character.charId,
              child: Image.network(
                character.charImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black
                        .withOpacity(0.9), // Adjust the opacity as needed
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new,
            color: MyColors.myWhite), // Change icon color as needed
        onPressed: () {
          Navigator.pop(context); // Navigate back
        },
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18,
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              color: MyColors.myWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Full Name : ', character.name),
                      buildDivider(260),
                      characterInfo('Title : ', character.nickname),
                      buildDivider(305),
                      characterInfo('Family : ', character.charFamily),
                      buildDivider(288),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
