import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/testTakingPage/save&DeleteUserQuestion.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/questionsIndex.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';
import 'package:testination/screens/mockeTest/durationConvertor.dart';

class TestPage extends StatefulWidget {
  final String icon;
  final String category;
  final String bundleName;
  final String name;
  final ThemeData theme;
  final Map testInfo;
  TestPage(
      {this.icon,
      this.bundleName,
      @required this.category,
      this.name,
      this.theme,
      this.testInfo});

  @override
  _TestPageState createState() => _TestPageState();
}

bool _showSpinner = false;

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    _showSpinner = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(_theme.primaryColorDark),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              height: 110,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    child: Image(
                      image: AssetImage('${widget.icon}'),
                      fit: BoxFit.contain,
                    ),
                    height: 110,
                    width: 110,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          '${widget.testInfo['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '${widget.testInfo['questions']} Questions',
                          style: TextStyle(
                              fontSize: 16,
                              color: widget.theme.accentColor.withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Duration ${secondsConvertor(widget.testInfo['duration'])}',
                          style: TextStyle(
                              fontSize: 16,
                              color: widget.theme.accentColor.withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(
              color: Colors.black54,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                _showSpinner = true;
                setState(() {});
                String test = widget.testInfo['name'];
                String name = widget.bundleName;
                String uid = Provider.of<MyAccount>(context, listen: false)
                    .userDetails['uid'];

                Map savedQuestionDetails =
                    await getSavedQuestions(widget.category, name, test, uid);
                if (savedQuestionDetails == null) {
                  Provider.of<QuestionAnswersProvider>(context, listen: false)
                      .retrieveSavedQuestionData({}, true);
                } else {
                  print('provider called in reterive saved');
                  Provider.of<QuestionAnswersProvider>(context, listen: false)
                      .retrieveSavedQuestionData(savedQuestionDetails, false);
                }
                _showSpinner = false;
                // print(widget.testInfo['section']);

                setState(() {});
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionsPage(
                        testDetails: widget.testInfo,
                        bundleName: widget.bundleName,
                        category: widget.category,
                      ),
                    ));
              },
              child: Container(
                child: Text(
                  'Start Test',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.theme.buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
