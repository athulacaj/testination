import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/testTakingPage/save&DeleteUserQuestion.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/supporters/timeConvertor.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../qusetionAnswerProvider.dart';

bool _pageActive;

class PauseTimer extends StatefulWidget {
  final int time;
  final String category;
  final String bundleName;
  final String test;
  final int totalTimedSpend;
  PauseTimer(
    this.time,
    this.totalTimedSpend,
    this.category,
    this.bundleName,
    this.test,
  );
  @override
  _PauseTimerState createState() => _PauseTimerState();
}

class _PauseTimerState extends State<PauseTimer> {
  bool _isPause = false;
  int _totalTime;
//  final int _secondsFactor = 1000000;

  final CountdownController _countController = CountdownController();

  ThemeData theme;
  @override
  void initState() {
    _totalTime = widget.time;
    timerFunction();
    super.initState();
  }

  void timerFunction() {
    try {
      if (widget.totalTimedSpend > _totalTime) {
        _totalTime = 1;
      } else {
        _totalTime = widget.time - widget.totalTimedSpend;
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    print('time spend   ${widget.totalTimedSpend}');
    _pageActive = true;
    theme = Theme.of(context);
    return Row(
      children: <Widget>[
        _isPause
            ? GestureDetector(
                onTap: () {
                  _countController.onResume();
                  _isPause = false;
                  setState(() {});
                },
                child: Icon(Icons.play_circle_outline,
                    color: Colors.green, size: 35),
              )
            : GestureDetector(
                onTap: () {
                  List saveQuestionSData = Provider.of<QuestionAnswersProvider>(
                          context,
                          listen: false)
                      .saveQuestionData();
                  String uid = Provider.of<MyAccount>(context, listen: false)
                      .userDetails['uid'];
                  saveQuestionsTimeData(widget.category, widget.bundleName,
                      widget.test, saveQuestionSData, uid);
                  _countController.pause();
                  _isPause = true;
                  setState(() {});
                },
                child: Icon(Icons.pause, color: Colors.green, size: 35),
              ),
        Countdown(
          controller: _countController,
          seconds: _totalTime,
          build: (BuildContext context, double time) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
//                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: returnText(time, _isPause, context),
          ),
          interval: Duration(seconds: 1),
          onFinished: () {
            print('Timer is done!');
          },
        ),
      ],
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _pageActive = false;
    super.deactivate();
  }
}

Widget returnText(var time, bool paused, BuildContext context) {
  if (_pageActive == true && paused == false) {
    Provider.of<QuestionAnswersProvider>(context, listen: false)
        .addTimeOfEachQuestion();
  }
  return Text(
    timeConvertor(time),
    style: TextStyle(fontSize: 17),
  );
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
