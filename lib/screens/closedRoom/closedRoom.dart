import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testination/screens/mockeTest/mocktestIndex.dart';

class ClosedRoomScreen extends StatefulWidget {
  final List closedRoomData;
  ClosedRoomScreen({this.closedRoomData});
  @override
  _ClosedRoomScreenState createState() => _ClosedRoomScreenState();
}

class _ClosedRoomScreenState extends State<ClosedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
                          'Closed Room',
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
          Container(
            height: 50,
            color: theme.backgroundColor,
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     Material(
            //       color: theme.buttonColor,
            //       elevation: 2,
            //       child: Container(
            //         alignment: Alignment.center,
            //         height: 30,
            //         width: 100,
            //         child: Text(
            //           'Filter',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //   ],
            // ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 465,
//                  decoration: KcontainerDecocartion1,
                  child: GridView.builder(
                    itemCount: widget.closedRoomData.length,
                    padding: EdgeInsets.only(left: 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      Map data = widget.closedRoomData[index];
                      String name = data['name'].toString().toLowerCase();
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings:
                                        RouteSettings(name: "/MockTestIndex"),
                                    builder: (context) => MockTestIndex(
                                          heading: data['name'],
                                          allData: data,
                                          category: data['category'],
                                          bundelName: data['name'],
                                          isBought: true,
                                        )));
                          },
                          child: Material(
                            color: theme.backgroundColor,
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(CupertinoIcons.book, size: 40),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                      ),
                                      Text(
                                        '${data['name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 3),
                                      Text(' Mock Test series'),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          topRight: Radius.circular(20),
                                        )),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 30,
                                    child: Text(
                                      'Bought ',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
