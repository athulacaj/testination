import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../qusetionAnswerProvider.dart';

class MyBottomModalSheet extends StatelessWidget {
  final int indexOfCurrentQuestion;
  final int totalQuestions;
  MyBottomModalSheet(
      {this.indexOfCurrentQuestion, @required this.totalQuestions});

  @override
  Widget build(context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(22.0),
                topRight: const Radius.circular(22.0))),
        child: ListView(
          children: <Widget>[
            buildQuestionBox(totalQuestions, indexOfCurrentQuestion, context),
          ],
        ),
      ),
    );
  }
}

Widget buildQuestionBox(int totalQuestion, int currentQ, BuildContext context) {
  ThemeData theme = Theme.of(context);
//  BuildContext _context = questionAnswerscaffoldKey.currentContext;
  var _provider = Provider.of<QuestionAnswersProvider>(context, listen: false);
  List<Widget> colum0 = [];
  List<Widget> colum1 = [];
  List<Widget> colum2 = [];
  List<Widget> colum3 = [];
  List<Widget> colum4 = [];
  List<List> allColums = [colum0, colum1, colum2, colum3, colum4];
  for (int i = 0; i < totalQuestion; i++) {
    int optionSelected = _provider.answeredList[i]['selected'];
    bool isMarked = _provider.markedList[i]['marked'];
    Widget toAdd = GestureDetector(
      onTap: () {
        _provider.changeQuestionIndex(i);
        Navigator.pop(context, '1');
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
//        border: Border.all(color: Colors.black.withOpacity(0.5)),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          elevation: 4,
          child: Container(
            width: (MediaQuery.of(context).size.width / 5) - 16,
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Positioned(
                  width: (MediaQuery.of(context).size.width / 5) - 16,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${i + 1}',
                        style: TextStyle(
                            fontSize: 18,
                            color: isMarked == true
                                ? Colors.white
                                : optionSelected > -1
                                    ? Colors.white
                                    : theme.accentColor),
                      ),
                    ],
                  ),
                ),
                currentQ == i
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.blueGrey,
                        ))
                    : Container(),
              ],
            ),
            decoration: BoxDecoration(
              color: isMarked == true
                  ? optionSelected > -1
                      ? Colors.orangeAccent.withOpacity(0.6)
                      : Colors.orangeAccent.withOpacity(1)
                  : optionSelected > -1
                      ? Colors.green.shade500
                      : Colors.black.withOpacity(0.02),
//            border: Border.all(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
      ),
    );

    if (i <= 4) {
      allColums[i].add(toAdd);
    } else {
      int index = (i % 5);
      allColums[index].add(toAdd);
    }
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: colum0,
          ),
        ),
        Expanded(
          child: Column(
            children: colum1,
          ),
        ),
        Expanded(
          child: Column(
            children: colum2,
          ),
        ),
        Expanded(
          child: Column(
            children: colum3,
          ),
        ),
        Expanded(
          child: Column(
            children: colum4,
          ),
        ),
      ],
    ),
  );
}
