import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:google_fonts/google_fonts.dart';

Future<String> imageLinkConvert(String notes, Size size) async {
  List notesList = notes.split("!!");
  List toReturn = [];
  for (String note in notesList) {
    if (note.length >= 5) {
      if (note.substring(0, 4) == '<img') {
//             var imgSplitImageTag=entry.split(/src\=\'(.*)\'\s/gs);

        final intRegex = RegExp(r"src\=\'(.*)\'\s", multiLine: true);
        String splitedImg = intRegex
            .allMatches(note)
            .map((m) => m.group(0))
            .toString()
            .split("'")[1];
        List imgSplitImageTag = note.split(new RegExp(r"src\=\'(.*)\'\s"));
        String url = await getUrl(splitedImg);
        int l = imgSplitImageTag[1].length - 3;
        print(imgSplitImageTag[1][l]);
        String temp = '';
        if (imgSplitImageTag[1][l] == 'L') {
          temp = r"<img src='" +
              url +
              "' style='width:${size.width - 30}px;margin:5px;'>";
        } else if (imgSplitImageTag[1][l] == 'M') {
          temp = "<img src=" +
              "'" +
              url +
              "' " +
              "' style='width:${size.width / 2.5}px;margin:5px;'>";
        } else {
          temp = "<img src=" +
              "'" +
              url +
              "' " +
              "' style='max-width:150px;max-height:50px;margin-top:10px;'>";
        }
        toReturn.add(temp);
      } else {
        toReturn.add(note);
      }
    } else {
      toReturn.add(note);
    }
  }
  return ("<div style='min-height:${size.height}px'>" +
      toReturn.join('') +
      '<br></div>');
}

Future<String> getUrl(String ref) async {
  String url = '';
  try {
    url = await firebase_storage.FirebaseStorage.instance
        .ref(ref)
        .getDownloadURL();
    print("gs://testination-e6442.appspot.com/$ref");
  } catch (e) {
    print(e);
  }
  return url;
}

class IndividualSolution extends StatefulWidget {
  String sltn;
  IndividualSolution({this.sltn});
  @override
  _IndividualSolutionState createState() => _IndividualSolutionState();
}

class _IndividualSolutionState extends State<IndividualSolution> {
  final TeXViewRenderingEngine renderingEngine =
      const TeXViewRenderingEngine.katex();
  String solution = '';
  @override
  void initState() {
    initFunction();
    super.initState();
  }

  void initFunction() async {
    print(widget.sltn);
    solution = "nothing";
    Size size = MediaQuery.of(context).size;
    solution = await imageLinkConvert(widget.sltn, size);
    // setState(() {});
  }

  String newNotes = r"<div style='height:500px'>hi</div>";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String style = r"background-color:tomato;color:white";
    var style =
        TeXViewStyle.fromCSS('padding: 15px; color: white; background: green');
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height - 78,
              child: TeXView(
                renderingEngine: renderingEngine,
                child: TeXViewContainer(
                  child: TeXViewColumn(
                      style: TeXViewStyle(
                        backgroundColor: Colors.white,
                        margin: TeXViewMargin.all(10),
                        padding: TeXViewPadding.all(10),
                        borderRadius: TeXViewBorderRadius.all(10),
                      ),
                      children: [
                        TeXViewDocument(widget.sltn,
                            style: TeXViewStyle(
                                fontStyle: TeXViewFontStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                    sizeUnit: TeXViewSizeUnit.Pixels,
                                    fontWeight: TeXViewFontWeight.w300
                                    // fontFamily: GoogleFonts.akronim().fontFamily,
                                    ))),
                      ]),
                ),
                // style: TeXViewStyle(height: (size.height + 2500).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TeXViewWidget _teXViewWidget(String title, String body) {
  return TeXViewColumn(
      style: TeXViewStyle(
          margin: TeXViewMargin.all(10),
          padding: TeXViewPadding.all(10),
          borderRadius: TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderWidth: 2,
              borderStyle: TeXViewBorderStyle.Groove,
              borderColor: Colors.green))),
      children: [
        TeXViewDocument(title,
            style: TeXViewStyle(
                padding: TeXViewPadding.all(10),
                borderRadius: TeXViewBorderRadius.all(10),
                textAlign: TeXViewTextAlign.Center,
                width: 250,
                margin: TeXViewMargin.zeroAuto(),
                backgroundColor: Colors.green)),
        TeXViewDocument(body,
            style: TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
      ]);
}
