import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';

class DemoNotes extends StatefulWidget {
  @override
  _DemoNotesState createState() => _DemoNotesState();
}

class _DemoNotesState extends State<DemoNotes> {
  final TeXViewRenderingEngine renderingEngine =
      const TeXViewRenderingEngine.mathjax();

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

  @override
  void initState() {
    super.initState();
  }

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

  String newNotes = r"<div style='height:500px'>hi</div>";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String style = r"background-color:tomato;color:white";
    var style =
        TeXViewStyle.fromCSS('padding: 15px; color: white; background: green');
    TeXViewWidget quadraticEquation = _teXViewWidget(
        r"<h4 style='background-color:tomato;color:white'>Quadratic Equation</h4>",
        r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and \<h2 style={color:red}>they are</h2>
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2abc}.$$<br>""");
    String notes =
        r"hi <br> <br> testing adding a image<br> !!<img src='addNotes/2021/0/1611068342018-playstore.png'  class='imgSmS'>!!";
    // notes =
    // r"$$log2x +{ log_2 x\over log24 }= log0.25√6$$ <br> $$A(n) \in \Theta(n^{\log_b a}) = \Theta(n^{\log_2 2} ) = \Theta(n)$$ <br> <br> $$log sin 1° - log sin 1°) +(log sin 2° - log sin 2°)+ log tan 1°cot 1° + log tan 2°cot 2°$$ <br> <br>  \(What is the sum of 71 + 262 + 633 + 1244 + 2155 .... 19 terms or 7 + 13 + 21 + 31 + 43 + 57 + 73... 19 terms?\) ";

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: () async {
                  newNotes = await imageLinkConvert(notes, size);
                  // newNotes = 'hi athul';
                  print('new notes = $newNotes');
                  setState(() {});
                },
                child: Text('get data')),
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
                        // border: TeXViewBorder.all(
                        //   TeXViewBorderDecoration(
                        //       borderWidth: 2,
                        //       borderStyle: TeXViewBorderStyle.Groove,
                        //       borderColor: Colors.white),
                        // ),
                      ),
                      children: [
                        // quadraticEquation,
                        TeXViewDocument(newNotes,
                            style: TeXViewStyle(
                                fontStyle: TeXViewFontStyle(
                              fontSize: 16,
                              sizeUnit: TeXViewSizeUnit.Pixels,
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

TeXViewWidget relationEnergyPrincipalQuantum = _teXViewWidget(
    r"<h4>Relationship between Energy and Principal Quantum Number</h4>",
    r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

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
