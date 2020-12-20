import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'durationConvertor.dart';
import 'mockTestIno/mockTestInfo.dart';
import 'allIcons.dart';

class MockTestIndexClosedRoom extends StatefulWidget {
  final String heading;
  final String type;
  final String category;
  final List tests;
  final String bundleName;
  MockTestIndexClosedRoom(
      {this.heading,
      @required this.category,
      this.bundleName,
      @required this.type,
      this.tests});
  @override
  _MockTestIndexClosedRoomState createState() =>
      _MockTestIndexClosedRoomState();
}

class _MockTestIndexClosedRoomState extends State<MockTestIndexClosedRoom> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${widget.type} by ${widget.heading}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SizedBox(width: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            color: theme.backgroundColor,
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: widget.tests.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    if (widget.tests[i]['free'] == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MockTestInfo(
                                    testInfo: widget.tests[i],
                                    category: widget.bundleName,
                                    icon: AllIcons().allIcons[i],
                                    name: '${widget.tests[i]['name']}',
                                  )));
                    }
                  },
                  child: Material(
//                    color: Colors.white,
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    elevation: 1,
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image(
                                          image: AssetImage(
                                              '${AllIcons().allIcons[i]}'),
                                          fit: BoxFit.scaleDown,
                                        ),
                                        height: 60,
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                widget.tests[i]['free'] == false
                                    ? Container(
                                        decoration: BoxDecoration(
//                                          color: Colors.black.withOpacity(0.1),
                                          gradient: LinearGradient(colors: [
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.6)
                                          ]),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              bottomLeft: Radius.circular(6)),
                                        ),
                                      )
                                    : Container(),
                                widget.tests[i]['free'] == false
                                    ? Positioned(
                                        top: 1,
                                        right: 1,
                                        child: Icon(
                                          Icons.lock,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6)),
                            ),
                            width: 100,
                            padding: EdgeInsets.only(left: 0),
                          ),
                          SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${widget.tests[i]['name']}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${widget.tests[i]['questions']} Questions',
                                style: TextStyle(
                                    color: theme.accentColor.withOpacity(0.6)),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  '${secondsConvertor(widget.tests[i]['duration'])}',
                                  style: TextStyle(
                                      color:
                                          theme.accentColor.withOpacity(0.6)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
