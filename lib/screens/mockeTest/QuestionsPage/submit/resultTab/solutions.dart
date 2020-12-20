import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:provider/provider.dart';
import 'package:testination/homeScreen/homeScreen.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/supporters/timeConvertor.dart';

import '../../qusetionAnswerProvider.dart';

class Solutions extends StatefulWidget {
  final Map solutionDetails;
  Solutions({this.solutionDetails});
  @override
  _SolutionsState createState() => _SolutionsState();
}

String filter = 'all';

class _SolutionsState extends State<Solutions> {
  @override
  void initState() {
    filter = 'all';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List answeredList =
        Provider.of<QuestionAnswersProvider>(context, listen: false)
            .answeredList;
//    print(answeredList);
    List questionsAndAnswers = widget.solutionDetails['solutionDetails'];
    print(questionsAndAnswers);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Solutions ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SizedBox(width: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            color: theme.backgroundColor,
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 70),
              itemCount: questionsAndAnswers.length,
              itemBuilder: (BuildContext context, int i) {
                Map qMap = questionsAndAnswers[i];
                Map aMap = answeredList[i];
                return sortQuestions(filter, theme, context, i, qMap, aMap);
              },
            ),
          )
        ],
      ),
      floatingActionButton: BoomMenu(
        backgroundColor: theme.buttonColor,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        onOpen: () => print('OPENING DIAL'),
        onClose: () {
          setState(() {});
        },
//        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          buildMenuItem(context, 'all'),
          buildMenuItem(context, 'Wrong'),
          buildMenuItem(context, 'Correct'),
          buildMenuItem(context, 'Not Answered'),
          buildMenuItem(context, 'Guessed'),
        ],
      ),
    );
  }
}

Widget sortQuestions(String title, ThemeData theme, BuildContext context, int i,
    Map qMap, Map aMap) {
  Widget toReturn = Container(
    color: theme.backgroundColor.withOpacity(0.8),
    margin: EdgeInsets.only(bottom: 3),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    child: Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 22),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Q${i + 1}',
                    style: TextStyle(
                        fontSize: 18,
                        color: qMap['isCorrect'] == true
                            ? Colors.green
                            : qMap['isCorrect'] == false
                                ? Colors.redAccent
                                : theme.accentColor),
                  ),
                  Expanded(
                      child: Text(
                    ': ${qMap['question']}',
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Icon(Icons.vpn_key, size: 10),
                SizedBox(width: 5),
                Expanded(
                  child: Material(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 28, top: 8, bottom: 4),
                      child: Text(
                        '${qMap['options'][qMap['answerIndex']]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
        Positioned(
          right: 0,
          child: SizedBox(
            width: 55,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.access_time,
                  color: theme.accentColor.withOpacity(0.2),
                ),
                Spacer(),
                Text('${timeConvertor(qMap['timeSpend'] * 1.0)}'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  if (title.toLowerCase() == 'all') {
    return toReturn;
  }
  if (title.toLowerCase() == 'correct') {
    if (qMap['isCorrect'] == true) {
      return toReturn;
    } else {
      return Container();
    }
  }
  if (title.toLowerCase() == 'wrong') {
    if (qMap['isCorrect'] == false) {
      return toReturn;
    } else {
      return Container();
    }
  }
  if (title.toLowerCase() == 'not answered') {
    if (qMap['isCorrect'] != true && qMap['isCorrect'] != false) {
      return toReturn;
    } else {
      return Container();
    }
  }
  if (title.toLowerCase() == 'guessed') {
    print(aMap);
    if (aMap['isGuessed'] == true) {
      return toReturn;
    } else {
      return Container();
    }
  }
}

MenuItem buildMenuItem(BuildContext context, String title) {
  ThemeData _theme = Theme.of(context);
  return MenuItem(
    backgroundColor: title == filter ? Color(0xff49CC7F) : Colors.white,
//            child: Icon(Icons.accessibility, color: Colors.black),
    child: Container(
      width: MediaQuery.of(context).size.width - 60,
      alignment: Alignment.center,
      child: Text(
        '$title',
        style: TextStyle(color: title == filter ? Colors.white : Colors.black),
      ),
    ),
    title: "",
    titleColor: Colors.white,

    subtitle: "",
    subTitleColor: Colors.white,
//            backgroundColor: Colors.deepOrange,
    onTap: () {
      filter = title;
    },
  );
}
