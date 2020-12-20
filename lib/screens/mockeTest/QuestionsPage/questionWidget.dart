import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';

import 'optionsWidget.dart';

int _selectedIndex = -1;
//
//class QuestionAndOption extends StatefulWidget {
//  final Map questionAnswer;
//  final int qNo;
//  QuestionAndOption({this.questionAnswer, @required this.qNo});
//  @override
//  _QuestionAndOptionState createState() => _QuestionAndOptionState();
//}
//
//class _QuestionAndOptionState extends State<QuestionAndOption> {
//  @override
//  Widget build(BuildContext context) {
//    ThemeData theme = Theme.of(context);
//    String question = widget.questionAnswer['question'];
//    List<String> options = widget.questionAnswer['options'];
//    int answerIndex = widget.questionAnswer['answerIndex'];
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView(
//              padding: EdgeInsets.all(0),
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(top: 1),
//                  child: Material(
//                    elevation: 1,
//                    child: Stack(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(
//                              left: 21, right: 21, top: 5, bottom: 5),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              SizedBox(height: 10),
//                              Text(
//                                'Title',
//                                style: TextStyle(
//                                    fontSize: 18, fontWeight: FontWeight.w600),
//                              ),
//                              SizedBox(height: 10),
//                              Text(
//                                '$question',
//                                style: TextStyle(fontSize: 17),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Positioned(
//                          right: 0,
//                          child: Container(
//                              width: 50,
//                              height: 18,
//                              alignment: Alignment.center,
//                              decoration: BoxDecoration(color: Colors.black87),
//                              child: Text('Guess',
//                                  style: TextStyle(color: Colors.white))),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                SizedBox(height: 0),
//                Padding(
////                  padding: const EdgeInsets.symmetric(horizontal: 19),
//                  padding: EdgeInsets.only(left: 23, right: 19, bottom: 20),
//                  child: Options(
//                    selectedIndex: _selectedIndex,
//                    options: options,
//                    qNo: widget.qNo,
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

class QuestionAndOption extends StatelessWidget {
  final Map questionAnswer;
  final int qNo;
  QuestionAndOption({this.questionAnswer, @required this.qNo});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String question = questionAnswer['question'];
    List options = questionAnswer['options'];
    int answerIndex = questionAnswer['answerIndex'];
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 900),
        builder: (BuildContext context, double opacity, Widget child) {
          return Opacity(
            opacity: opacity,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Material(
                            elevation: 1,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 21, right: 21, top: 5, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Text(
                                        'Title',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '$question',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<QuestionAnswersProvider>(
                                  builder: (BuildContext context, provider,
                                      Widget child) {
                                    bool isGuessed =
                                        provider.answeredList[qNo]['isGuessed'];
                                    int optionIndex =
                                        provider.answeredList[qNo]['selected'];
                                    return isGuessed
                                        ? Positioned(
                                            right: 5,
                                            child: Container(
                                                width: 65,
                                                height: 18,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.black87),
                                                child: Text(
                                                    optionIndex == -1
                                                        ? 'Guess'
                                                        : 'Guessed',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          )
                                        : Container();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 0),
                        Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 19),
                          padding:
                              EdgeInsets.only(left: 23, right: 19, bottom: 20),
                          child: Options(
                            selectedIndex: _selectedIndex,
                            options: options,
                            qNo: qNo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
