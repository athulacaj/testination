import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';

import 'optionsWidget.dart';

int _selectedIndex = -1;

class QuestionAndOption extends StatelessWidget {
  final Map questionAnswer;
  final int qNo;
  QuestionAndOption({this.questionAnswer, @required this.qNo});
  final TeXViewRenderingEngine renderingEngine =
      const TeXViewRenderingEngine.katex();
  String tx =
      r"<div style=' height:500px'><img src=https://firebasestorage.googleapis.com/v0/b/testination-e6442.appspot.com/o/addNotes%2F2021%2F0%2F1611469938157-WhatsApp%20Image%202020-12-14%20at%204.11.17%20PM.jpg?alt=media&token=b7bb4403-6a8f-4617-9cd5-ec7e5180aaab' class='imgSmL' height='500px' style='float:left' ></div>"
      r"hjhjghjgjh dfgjdflh hgdfnhsg hgdlhg hglnhglhghslkghlkg hglnshlnhg lsghl'gf sh";
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
          ThemeData theme = Theme.of(context);
          Size size = MediaQuery.of(context).size;
          return Opacity(
            opacity: opacity,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: 100, maxHeight: size.height / 1.75),
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: Material(
                                  elevation: 1,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 21,
                                            right: 21,
                                            top: 5,
                                            bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            // Text(
                                            //   'Title',
                                            //   style: TextStyle(
                                            //       fontSize: 18,
                                            //       fontWeight: FontWeight.w600),
                                            // ),
                                            SizedBox(height: 10),
                                            isHtml(question)
                                                ? TeXView(
                                                    renderingEngine:
                                                        renderingEngine,
                                                    loadingWidgetBuilder:
                                                        (context) {
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    child: TeXViewContainer(
                                                        style: TeXViewStyle(
                                                            contentColor: theme
                                                                .accentColor,
                                                            backgroundColor: theme
                                                                .backgroundColor
                                                                .withOpacity(
                                                                    0.01)),
                                                        child: TeXViewColumn(
                                                            children: [
                                                              TeXViewDocument(
                                                                  tx,
                                                                  style:
                                                                      TeXViewStyle(
                                                                          fontStyle:
                                                                              TeXViewFontStyle(
                                                                    fontSize:
                                                                        16,
                                                                    sizeUnit:
                                                                        TeXViewSizeUnit
                                                                            .Pixels,
                                                                    // fontFamily: GoogleFonts.akronim().fontFamily,
                                                                  ))),
                                                            ])),
                                                  )
                                                : Text(
                                                    '$question',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Consumer<QuestionAnswersProvider>(
                                        builder: (BuildContext context,
                                            provider, Widget child) {
                                          bool isGuessed = provider
                                              .answeredList[qNo]['isGuessed'];
                                          int optionIndex = provider
                                              .answeredList[qNo]['selected'];
                                          return isGuessed
                                              ? Positioned(
                                                  right: 5,
                                                  child: Container(
                                                      width: 65,
                                                      height: 18,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.black87),
                                                      child: Text(
                                                          optionIndex == -1
                                                              ? 'Guess'
                                                              : 'Guessed',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                )
                                              : Container();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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

bool isHtml(String text) {
  if (text.contains(r'$$') ||
      text.contains(r'\(') ||
      text.contains(r'</') ||
      text.contains(r'<img src=')) {
    print("html");
    return true;
  }
  return false;
}
