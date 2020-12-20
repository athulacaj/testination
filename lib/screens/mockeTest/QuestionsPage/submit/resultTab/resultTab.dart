import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/testTakingPage/saveAndGetResults.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/submit/submitIndex.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/supporters/timeConvertor.dart';

import '../../qusetionAnswerProvider.dart';
import 'solutions.dart';

String _docId;
//List questionsAndAnswers = questionAnswers;
bool initCalledOnce = false;
var total;
Map accountDetails;
void saveResult(String docId, Map resultData, uid) async {
  if (initCalledOnce == false) {
    await Future.delayed(Duration(milliseconds: 200));
    await saveResultToDataBase(docId, resultData, uid);
    await saveDataToLeaderBoard(docId, uid, total, accountDetails);
  }
  initCalledOnce = true;
}

class ResultTabPage extends StatefulWidget {
  final List<dynamic> questionsAndAnswers;
  final String docId;
  ResultTabPage({@required this.questionsAndAnswers, this.docId});

  @override
  _ResultTabPageState createState() => _ResultTabPageState();
}

class _ResultTabPageState extends State<ResultTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    total = checkAnswerIsCorrect(widget.questionsAndAnswers, context,
        widget.questionsAndAnswers)['total'];
    final ThemeData theme = Theme.of(context);
    _docId = widget.docId;
    return ListView(
      padding: EdgeInsets.all(15),
      children: <Widget>[
        Text(
          'Overall Marks',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 68) / 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Positive Marks',
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  Text(checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                      widget.questionsAndAnswers)['positive']),
                ],
              ),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                  left: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 68) / 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Negative Marks',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  SizedBox(height: 10),
                  Text(checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                      widget.questionsAndAnswers)['negative']),
                ],
              ),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Text(
            'Total : ${checkAnswerIsCorrect(widget.questionsAndAnswers, context, widget.questionsAndAnswers)['total']}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
        SizedBox(height: 42),
        Text(
          'Time Distribution',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 18),
        Container(
          height: 70,
          padding: EdgeInsets.only(left: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.access_time),
                  SizedBox(width: 5),
                  Text('Correct Answer Time'),
                  SizedBox(width: 10),
                  Text(timeConvertor(double.parse(checkAnswerIsCorrect(
                      widget.questionsAndAnswers,
                      context,
                      widget.questionsAndAnswers)['positiveTime']))),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.access_time),
                  SizedBox(width: 5),
                  Text('Wrong Answer Time'),
                  SizedBox(width: 10),
                  Text(timeConvertor(double.parse(checkAnswerIsCorrect(
                      widget.questionsAndAnswers,
                      context,
                      widget.questionsAndAnswers)['negativeTime']))),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Text(
          'More Details',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildMoreDetailsRow(
                context,
                'Guessed Correct',
                checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                        widget.questionsAndAnswers)['guessedCorrect']
                    .toString()),
            buildMoreDetailsRow(
                context,
                'Guessed wrong',
                checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                        widget.questionsAndAnswers)['guessedWrong']
                    .toString()),
            buildMoreDetailsRow(
                context,
                'Switched wrong to correct',
                checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                            widget.questionsAndAnswers)['changedMap']
                        ['wrongToCorrect']
                    .toString()),
            buildMoreDetailsRow(
                context,
                'Switched correct to wrong',
                checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                            widget.questionsAndAnswers)['changedMap']
                        ['correctToWrong']
                    .toString()),
            buildMoreDetailsRow(
                context,
                'Switched wrong to wrong',
                checkAnswerIsCorrect(widget.questionsAndAnswers, context,
                            widget.questionsAndAnswers)['changedMap']
                        ['wrongToWrong']
                    .toString()),
          ],
        ),
        SizedBox(height: 25),
        solutionsButton(widget, context, theme),
        SizedBox(height: 0),
      ],
    );
  }
}

Widget solutionsButton(var widget, BuildContext context, ThemeData theme) {
  String uid =
      Provider.of<MyAccount>(context, listen: false).userDetails['uid'];
  accountDetails = Provider.of<MyAccount>(context, listen: false).userDetails;

  saveResult(_docId, toSaveToDataBase, uid);
  return GestureDetector(
    onTap: () {
      Map solutionDetails = checkAnswerIsCorrect(
          widget.questionsAndAnswers, context, widget.questionsAndAnswers);
      // print(toSaveToDataBase);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Solutions(
            solutionDetails: solutionDetails,
          ),
        ),
      );
    },
    child: Container(
      width: double.infinity,
      color: theme.primaryColorLight,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        'Solutions',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Map toSaveToDataBase;

Map checkAnswerIsCorrect(
    List qNAnswers, BuildContext context, List questionsAndAnswers) {
  // GlobalKey key = submitKey;
  BuildContext bcontext = context;
  List optionsSelected =
      Provider.of<QuestionAnswersProvider>(bcontext, listen: false)
          .answeredList;
  Map resultMap;
  List allQuestionList = [];
  int positive = 0;
  var positiveTime = 0;
  int negative = 0;
  var negativeTime = 0;
  var unSelectedTime = 0;
  int guessedCorrect = 0;
  int guessedWrong = 0;
  Map changedOption = {
    'wrongToCorrect': 0,
    'correctToWrong': 0,
    'wrongToWrong': 0
  };
  for (int i = 0; i < questionsAndAnswers.length; i++) {
//    if answer is correct
    if (qNAnswers[i]['answerIndex'] == optionsSelected[i]['selected']) {
      var timeSpend = optionsSelected[i]['timeSpend'];
      positiveTime = positiveTime + optionsSelected[i]['timeSpend'];
      var toAdd = new Map.from(questionsAndAnswers[i])
        ..addAll({'isCorrect': true, 'timeSpend': timeSpend});
      allQuestionList.add(toAdd);
      positive++;
//check guessed
      if (optionsSelected[i]['isGuessed'] == true) {
        guessedCorrect++;
      }
      // check changed
      if (optionsSelected[i]['previousSelected'] != -1) {
        changedOption['wrongToCorrect']++;
      }
    } else if (optionsSelected[i]['selected'] != -1) {
      var timeSpend = optionsSelected[i]['timeSpend'];

      if (qNAnswers[i]['answerIndex'] != optionsSelected[i]['selected']) {
        negativeTime = negativeTime + optionsSelected[i]['timeSpend'];
        var toAdd = new Map.from(questionsAndAnswers[i])
          ..addAll({'isCorrect': false, 'timeSpend': timeSpend});
        allQuestionList.add(toAdd);
        negative++;
      }
//      check guessed
      if (optionsSelected[i]['isGuessed'] == true) {
        guessedWrong++;
      }
      // check changed
      if (optionsSelected[i]['previousSelected'] != -1) {
        // if  answer == previous selected answer
        if (qNAnswers[i]['answerIndex'] ==
            optionsSelected[i]['previousSelected']) {
          changedOption['correctToWrong']++;
        } else {
          changedOption['wrongToWrong']++;
        }
      }
    } else {
      var timeSpend = optionsSelected[i]['timeSpend'];
      unSelectedTime = unSelectedTime + optionsSelected[i]['timeSpend'];
      var toAdd = new Map.from(questionsAndAnswers[i])
        ..addAll({'isCorrect': null, 'timeSpend': timeSpend});
      allQuestionList.add(toAdd);
    }
  }
  toSaveToDataBase = {
    'correct': positive,
    'wrong': negative,
    'total': questionsAndAnswers.length,
    // total questions length
    'positiveTime': positiveTime,
    'negativeTime': negativeTime,
    'unSelectedTime': unSelectedTime,
    'time': negativeTime + positiveTime + unSelectedTime,
  };

  resultMap = {
    'positive': '$positive',
    'positiveTime': '$positiveTime',
    'negative': '$negative',
    'negativeTime': '$negativeTime',
    'total': positive - negative,
    'solutionDetails': allQuestionList,
    'guessedCorrect': guessedCorrect,
    'guessedWrong': guessedWrong,
    'changedMap': changedOption,
  };
  return resultMap;
}

Widget buildMoreDetailsRow(BuildContext context, String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(flex: 6, child: Text('$title')),
        Expanded(
          child: Text('$value'),
        ),
      ],
    ),
  );
}
