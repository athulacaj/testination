import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';

class Options extends StatefulWidget {
  final int selectedIndex;
  final List options;
  final int qNo;
  Options({this.selectedIndex, this.options, @required this.qNo});
  @override
  _OptionsState createState() => _OptionsState();
}

int selectedIndex;

class _OptionsState extends State<Options> {
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;

    super.initState();
  }

  bool fromOptionButton = false;
  final TeXViewRenderingEngine renderingEngine =
      const TeXViewRenderingEngine.katex();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: 1000), // **THIS is the important part**
      child: widget.options.length > 1
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (BuildContext context, int i) {
                return GestureDetector(
                  onTap: () {
                    if (i == selectedIndex) {
                      selectedIndex = -1;
                    } else {
                      selectedIndex = i;
                    }
                    Provider.of<QuestionAnswersProvider>(context, listen: false)
                        .addOptionToAnswerList(optionSelected: selectedIndex);
                    setState(() {});
                  },
                  child: Consumer<QuestionAnswersProvider>(
                    builder: (BuildContext context, provider, Widget child) {
                      int optionSelected = -1;
                      if (provider.answeredList.length > 0) {
                        optionSelected =
                            provider.answeredList[widget.qNo]['selected'];
                      }
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          elevation: 2,
                          color: optionSelected == i
                              ? theme.buttonColor.withOpacity(0.95)
                              : null,
                          child: AnimatedContainer(
                            width: MediaQuery.of(context).size.width - 42,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 6),
                            duration: Duration(milliseconds: 200),
                            child: isHtml(widget.options[i])
                                ? TeXView(
                                    onClicked: () {
                                      if (i == selectedIndex) {
                                        selectedIndex = -1;
                                      } else {
                                        selectedIndex = i;
                                      }
                                      Provider.of<QuestionAnswersProvider>(
                                              context,
                                              listen: false)
                                          .addOptionToAnswerList(
                                              optionSelected: selectedIndex);
                                      setState(() {});
                                    },
                                    isOnclickFunctionAvailable: true,
                                    renderingEngine: renderingEngine,
                                    child: TeXViewContainer(
                                      style: TeXViewStyle(
                                          contentColor: theme.accentColor,
                                          backgroundColor: optionSelected == i
                                              ? theme.buttonColor
                                                  .withOpacity(0.95)
                                              : theme.backgroundColor
                                                  .withOpacity(0.01)),
                                      child: TeXViewDocument(widget.options[i],
                                          style: TeXViewStyle(
                                              fontStyle: TeXViewFontStyle(
                                            fontSize: 16,
                                            sizeUnit: TeXViewSizeUnit.Pixels,
                                            // fontFamily: GoogleFonts.akronim().fontFamily,
                                          ))),
                                    ),
                                  )
                                : Text(
                                    '${widget.options[i]}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: optionSelected == i
                                            ? Colors.white
                                            : null),
                                  ),
                            decoration: BoxDecoration(
                                color: optionSelected == i
                                    ? theme.buttonColor.withOpacity(0.95)
                                    : null,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : null,
    );
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
