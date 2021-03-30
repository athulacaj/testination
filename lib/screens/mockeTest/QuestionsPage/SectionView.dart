import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SectionView extends StatefulWidget {
  final Map sectionData;
  SectionView(this.sectionData);

  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  @override
  Widget build(BuildContext context) {
    final TeXViewRenderingEngine renderingEngine =
        const TeXViewRenderingEngine.katex();
    String h = "style='min-height:10000px'>";
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    print(widget.sectionData);
    WebViewController _controller;

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          height: size.height - 140,
          child: WebView(
            initialUrl: 'about:blank',
            gestureRecognizers: Set()
              ..add(
                Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
                ),
              ), // or
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onPageFinished: (some) async {
              double height = double.parse(await _controller.evaluateJavascript(
                  "document.documentElement.scrollHeight;"));
              print("height $height");
              setState(() {
                // _heights[index] = height;
              });
            },
            onWebViewCreated: (WebViewController webViewController) async {
              _controller = webViewController;
              _loadHtmlFromAssets(_controller, result(widget.sectionData));
            },
          ),
        ),
      ],
    );
  }
}

class SectionMaker {
  List<dynamic> sectionList;

  SectionMaker(List<dynamic> sectionList) {
    this.sectionList = sectionList;
  }

  Map getSectionForEachQues(int qno) {
    print("section  Qno: $qno");
    if (sectionList != null) {
      for (int i = 1; i < sectionList.length; i++) {
        if (qno >= sectionList[i]["f"] && qno <= sectionList[i]["l"]) {
          Map sectionMap = sectionList[i];
          sectionMap['i'] = i;
          return sectionMap;
        }
      }
    }
  }
}

String result(Map sectionData) {
  String t = '';
  if (sectionData['instruction'] != null && sectionData['paragraph'] != null) {
    t = head +
        "<h3>" +
        'Section ${sectionData['i']} (Qno: ${sectionData['f']} - ${sectionData['l']})' +
        "</h3>"
            "<h4>" +
        sectionData['instruction'] +
        "</h4>" +
        sectionData['paragraph'] +
        foot;
  } else if (sectionData['instruction'] != null) {
    t = head +
        "<h3>" +
        'Section ${sectionData['i']} (Qno: ${sectionData['f']} - ${sectionData['l']})' +
        "</h3>"
            "<h4>" +
        sectionData['instruction'] +
        "</h4>" +
        foot;
  } else if (sectionData['paragraph'] != null) {
    t = head +
        "<h3>" +
        'Section ${sectionData['i']} (Qno: ${sectionData['f']} - ${sectionData['l']})' +
        "</h3>" +
        sectionData['paragraph'] +
        foot;
  }
  return t;
}

_loadHtmlFromAssets(WebViewController controller, String txt) async {
  controller.loadUrl(Uri.dataFromString(txt,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString());
}

String head = r'''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <script async="" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/MathJax.js?config=TeX-MML-AM_CHTML" type="text/javascript">
  </script>
  </script>
</head>
<body>
 ''';
String foot = r'''
</body>
</html>
''';
