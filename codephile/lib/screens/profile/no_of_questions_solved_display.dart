import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/no_of_questions_solved_tile.dart';
import 'package:flutter/material.dart';

class QuestionsSolvedDisplay extends StatelessWidget{
  final int codechefSubmissions;
  final int codeforcesSubmissions;
  final int hackerrankSubmissions;
  final int spojSubmissions;

  const QuestionsSolvedDisplay(
      this.codechefSubmissions,
      this.codeforcesSubmissions,
      this.hackerrankSubmissions,
      this.spojSubmissions, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Number of questions solved",
            style: TextStyle(
              color: primaryBlackText,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: SizedBox(
            height: 107,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                // TODO: remove hardcoding      Priority 1
                QuestionsSolvedTile("CodeChef", codechefSubmissions),
                QuestionsSolvedTile("Codeforces", codeforcesSubmissions),
                QuestionsSolvedTile("HackerRank", hackerrankSubmissions),
                QuestionsSolvedTile(" Spoj ", spojSubmissions),
              ],
            ),
          ),
        )
      ],
    );
  }

}
