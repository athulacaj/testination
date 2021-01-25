import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/testTakingPage/save&DeleteUserQuestion.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/submit/submitIndex.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'questionWidget.dart';
import 'qusetionAnswerProvider.dart';
import 'supporters/modalBottomSheet.dart';
import 'supporters/pauseButtonTimer.dart';
import 'supporters/questionDrawer.dart';
import 'yyBottomSheetDialog.dart';

TabController _questionController;

class QuestionsPage extends StatefulWidget {
  final String questionTitle;
  final Map testDetails;
  final String category;
  final String bundleName;
  QuestionsPage(
      {this.questionTitle,
      @required this.category,
      this.bundleName,
      this.testDetails});
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

ThemeData theme;
bool runTimer;
bool _isMore = false;
bool _isBookmarked = false;
List<dynamic> _questionAnswers = [];

class _QuestionsPageState extends State<QuestionsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _questionAnswers = widget.testDetails['test'];
    print(widget.testDetails['test']);
    runTimer = true;
    _isMore = false;
    _isBookmarked = false;
    var provider = Provider.of<QuestionAnswersProvider>(context, listen: false);
    _questionController =
        TabController(vsync: this, length: _questionAnswers.length);
    _questionController.index = provider.questionIndex;
    tabListener();
    print('index is ${_questionController.index}');
    provider.totalNoOfAnswersList(_questionAnswers.length);
    super.initState();
  }

  void changeIndex(int index) async {
    await Future.delayed(Duration(milliseconds: 500));
    Provider.of<QuestionAnswersProvider>(context, listen: false)
        .changeQuestionIndex(index);
  }

  void tabListener() {
    _questionController.addListener(() {
      int index = _questionController.index;
      Provider.of<QuestionAnswersProvider>(context, listen: false)
          .changeQuestionIndex(index);
    });
  }

  void closeModal(void value) {
    int index = Provider.of<QuestionAnswersProvider>(context, listen: false)
        .questionIndex;
    _questionController.index = index;
    print('modal closed');
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  CountdownController _countController = CountdownController();

  @override
  Widget build(BuildContext context) {
    changeIndex(_questionController.index);
    theme = Theme.of(context);
//    FlutterStatusbarcolor.setStatusBarColor(Colors.grey.withOpacity(0.001));
//    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return Scaffold(
      key: _scaffoldKey,
      drawer: QuestionDrawer(),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Column(
        children: <Widget>[
          Container(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                height: 50,
                child: Consumer<QuestionAnswersProvider>(
                    builder: (context, question, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.menu,
                                size: 35,
                              ),
                              onTap: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Future<void> future =
                                    showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int _currentQIndex =
                                        _questionController.index;
                                    return MyBottomModalSheet(
                                      indexOfCurrentQuestion: _currentQIndex,
                                      totalQuestions: _questionAnswers.length,
                                    );
                                  },
                                );
                                future.then((void value) => closeModal(value));
                              },
                              child: Material(
//                            color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  height: 34,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Question ',
                                        style: TextStyle(
//                                        color: theme.primaryColorLight,
                                            fontSize: 18),
                                      ),
                                      SizedBox(width: 3),
                                      Stack(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '${question.questionIndex + 1}/${_questionAnswers.length}',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(width: 25),
                                            ],
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: -2,
                                            child: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: theme.primaryColorLight,
                                                size: 30),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            runTimer == true
                                ? PauseTimer(
                                    widget.testDetails['duration'],
                                    question.totalTimeSpend,
                                    widget.category,
                                    widget.bundleName,
                                    widget.testDetails['name'],
                                    _isPause,
                                    _countController,
                                    resumeTimer,
                                    pauseTimer,
                                    onTimerFinished)
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                decoration: BoxDecoration(
//                  color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.5)))),
              ),
            ),
            color: theme.backgroundColor,
          ),
          Expanded(
            child: Stack(
              children: [
                TabBarView(
                  controller: _questionController,
                  children: <Widget>[
                    for (int i = 0; i < _questionAnswers.length; i++)
                      QuestionAndOption(
                        questionAnswer: _questionAnswers[i],
                        qNo: i,
                      ),
                  ],
                ),
                _isPause
                    ? Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              resumeTimer();
                            },
                            child: SizedBox(
                              height: 50,
                              width: 200,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_circle_fill, size: 50),
                                      Text('  Resume'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                isSubmitting
                    ? Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: SizedBox(
                          height: 70,
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 15),
                              Text(
                                'Submitting ...',
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<QuestionAnswersProvider>(
        builder: (BuildContext context, provider, Widget child) {
          bool isMarked =
              provider.markedList[_questionController.index]['marked'];
          _isBookmarked =
              provider.answeredList[_questionController.index]['isBookmarked'];
          return BottomNavigationBar(
            selectedItemColor: Colors.black45,
            onTap: (i) async {
              //submit
              if (i == 2) {
                submitFunction(context, widget);
              }
              //review
              if (i == 0) {
                isMarked = !isMarked;
                provider.addToMarkedList(isMarked);
                print(provider.markedList);
              }
              if (i == 1) {
                Future.delayed(Duration(milliseconds: 500));
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          BottomExpandMenu(_questionController.index),
                          SizedBox(height: 50),
                        ],
                      );
                    });
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.marker,
                  size: 20,
                  color: isMarked == true
                      ? Colors.redAccent
                      : theme.unselectedWidgetColor,
                ),
                title: isMarked == true
                    ? Text(
                        ' Marked',
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : Text(
                        'Mark for Review',
                        style: TextStyle(color: theme.unselectedWidgetColor),
                      ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.ellipsisH, size: 20),
                title: Text(
                  'More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.check, color: Colors.green),
                title: Text('Submit', style: TextStyle(color: Colors.green)),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _isPause = false;
  void resumeTimer() {
    _countController.onResume();
    _isPause = false;
    setState(() {});
  }

  void pauseTimer() {
    List saveQuestionSData =
        Provider.of<QuestionAnswersProvider>(context, listen: false)
            .saveQuestionData();
    String uid =
        Provider.of<MyAccount>(context, listen: false).userDetails['uid'];
    saveQuestionsTimeData(widget.category, widget.bundleName,
        widget.testDetails['name'], saveQuestionSData, uid);
    _countController.pause();
    _isPause = true;
    setState(() {});
  }

  void onTimerFinished() {
    submitFunction(context, widget);
  }

  bool isSubmitting = false;
  void submitFunction(BuildContext context, widget) async {
    isSubmitting = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    String uid =
        Provider.of<MyAccount>(context, listen: false).userDetails['uid'];

    deleteSavedQuestions(
        widget.category, widget.bundleName, widget.testDetails['name'], uid);
    runTimer = false;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SubmitPage(
                  questionsAndAnswers: _questionAnswers,
                  documentId:
                      '${widget.category}${widget.bundleName}${widget.testDetails['name']}',
                )));
  }
}
