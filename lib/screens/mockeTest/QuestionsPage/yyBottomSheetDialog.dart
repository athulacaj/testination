import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'qusetionAnswerProvider.dart';

class BottomExpandMenu extends StatelessWidget {
  final int index;
  BottomExpandMenu(this.index);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<QuestionAnswersProvider>(
      builder: (context, provider, child) {
        bool isBookmarked = provider.answeredList[index]['isBookmarked'];
        bool isGuessed = provider.answeredList[index]['isGuessed'];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Material(
                      elevation: 3,
                      child: Container(
                        height: 60,
                        color: theme.backgroundColor.withOpacity(0.5),
                        padding: EdgeInsets.all(1),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            isGuessed
                                ? FaIcon(FontAwesomeIcons.questionCircle,
                                    size: 20, color: Colors.blue)
                                : FaIcon(FontAwesomeIcons.question, size: 20),
                            Text(
                              'Guess',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    provider.addToGuess(!isGuessed);
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Material(
                      elevation: 3,
                      child: Container(
                        height: 60,
                        color: theme.backgroundColor.withOpacity(0.5),
                        padding: EdgeInsets.all(1),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            isBookmarked == false
                                ? FaIcon(FontAwesomeIcons.bookmark, size: 20)
                                : Icon(
                                    Icons.bookmark,
                                    color: Colors.blue,
                                  ),
                            Text(
                              isBookmarked == false ? 'Bookmark' : 'BookMarked',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    provider.addToBookmark(!isBookmarked);
                  },
                ),
              ),
//              Expanded(
//                child: GestureDetector(
//                  child: Padding(
//                    padding: const EdgeInsets.all(4.0),
//                    child: Material(
//                      elevation: 3,
//                      child: Container(
//                        height: 60,
//                        color: theme.backgroundColor.withOpacity(0.8),
//                        padding: EdgeInsets.all(1),
//                        alignment: Alignment.center,
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            FaIcon(FontAwesomeIcons.check,
//                                size: 20, color: Colors.green),
//                            Text(
//                              'Submit',
//                              style: TextStyle(color: Colors.green),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                  onTap: () {
//                    print('submit');
//                    Navigator.pop(context);
//                  },
//                ),
//              ),
            ],
          ),
        );
      },
    );
  }
}
