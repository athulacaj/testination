import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Contents extends StatelessWidget {
  final ThemeData theme;
  Contents({this.theme});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        padding: EdgeInsets.only(top: 15, bottom: 5),
        children: <Widget>[
          Text(
            'Syllabus',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Syllabus 1',
//                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Topic',
//                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text(
                      'Syllabus 2',
//                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Topic',
//                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: theme.accentColor.withOpacity(0.35))),
          ),
          SizedBox(height: 20),
          Text(
            'Materials',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                          width: 50,
                          child: Text(
                            'S1',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    color: theme.primaryColor),
                SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Image(
                                image: AssetImage('assets/icon1.png'),
                                fit: BoxFit.contain,
                              ),
                              height: 50,
                              width: 80,
                            ),
                            SizedBox(height: 6),

//                          Icon(CupertinoIcons.book_solid, size: 30),
                            Text(
                              'Material ${i + 1}',
//                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
//
                SizedBox(height: 16),
                Material(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                          width: 50,
                          child: Text(
                            'S2',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    color: theme.primaryColor),
                SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Image(
                                image: AssetImage('assets/icon1.png'),
                                fit: BoxFit.contain,
                              ),
                              height: 50,
                              width: 80,
                            ),
                            SizedBox(height: 6),
//                          Icon(CupertinoIcons.book_solid, size: 30),
                            Text(
                              'Material ${i + 1}',
//                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: theme.accentColor.withOpacity(0.35))),
          ),
        ],
      ),
    );
  }
}
