import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/testTakingPage/saveAndGetResults.dart';
import 'package:testination/provider/account.dart';

int tQ = 100;
int c = 6;
int w = 3;
int u = 1;
int total = 0;
double width = 30.0;
bool _showSpinner = true;
List<Map> _savedResult = [];
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CompareTab extends StatefulWidget {
  final String docId;
  CompareTab({this.docId});
  @override
  _CompareTabState createState() => _CompareTabState();
}

class _CompareTabState extends State<CompareTab> {
  @override
  void initState() {
    _showSpinner = true;
    width = 30;
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    _savedResult = [];
    _showSpinner = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String uid =
        Provider.of<MyAccount>(context, listen: false).userDetails['uid'];

    var size = MediaQuery.of(context).size;
    // return Container();
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('userEvents/questionsResult/${auth.currentUser.uid}')
          .doc('${widget.docId}$uid')
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _savedResult =
            List<Map>.from(snapshot.data.data()['list']).reversed.toList();

        if (_savedResult != []) {
          tQ = _savedResult[0]['total'];
          // tQ = 30;
          total = getTotal(tQ);
        }

        return _savedResult == []
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      buildChips(size, Color(0xff4BB543), 'Correct'),
                      buildChips(size, Color(0xffFB7483), 'Wrong'),
                      buildChips(size, Color(0xff9BAAB3), 'Un Answered'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                  Container(
                    height: size.height - 250,
                    width: size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 20,
                          left: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: buildScale(tQ, size),
                          ),
                        ),
                        _savedResult.length > 0
                            ? Positioned(
                                bottom: 5,
                                left: 20,
                                height: size.height - 250,
                                width: MediaQuery.of(context).size.width - 55,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _savedResult.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: graph(
                                          title:
                                              i == 0 ? 'Current' : 'Previous',
                                          size: size,
                                          correct: _savedResult[i]['correct'],
                                          wrong: _savedResult[i]['wrong'],
                                          total: total,
                                          unAnswered: _savedResult[i]['total'] -
                                              (_savedResult[i]['correct'] +
                                                  _savedResult[i]['wrong'])),
                                    );
                                  },
                                ))
                            : Positioned(
                                left: 40,
                                top: size.height / 4,
                                child: Text('error check Network connection')),
                        Positioned(
                          right: 0,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  if (width > 6) {
                                    width = width - 3;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: 0),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  width = width + 5;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black87)),
                  ),
                  Spacer(),
                ],
              );
      },
    );
  }
}

Widget buildChips(var size, Color color, String title) {
  return Container(
    alignment: Alignment.center,
    color: color,
    width: size.width / 3 - (38 / 3),
    height: 30,
    child: Text(
      '$title',
      style: TextStyle(color: Colors.white),
    ),
  );
}

int getTotal(var upperLimit) {
  var total = upperLimit;
  List<Widget> toReturn = [];
  var i = total;
  String lastDigit = '$total'.substring(total.toString().length - 1);
  if (lastDigit != '0') {
    i = total + (10 - int.parse(lastDigit));
    total = total + (10 - int.parse(lastDigit));
  }
  return total;
}

List<Widget> buildScale(var upperLimit, var size) {
  var total = upperLimit;
  List<Widget> toReturn = [];
  var i = total;
  String lastDigit = '$total'.substring(total.toString().length - 1);
  if (lastDigit != '0') {
    i = total + (10 - int.parse(lastDigit));
    total = total + (10 - int.parse(lastDigit));
    print('last didit:$i');
  }

  while (i > 0) {
    String toAdd = i.toString().split('.')[0];
    toReturn.add(Container(
        alignment: Alignment.bottomCenter,
        height: (size.height - 300) / 10,
        child: Text(
          '$toAdd',
          style: TextStyle(color: Colors.blue),
        )));
    i = i - (total / 10);
  }
  toReturn.add(Container(
      alignment: Alignment.bottomCenter,
      height: (size.height - 300) / 10,
      child: Text(
        '0',
        style: TextStyle(color: Colors.blue),
      )));

  return toReturn;
}

Widget graph(
    {String title,
    int total,
    var size,
    int correct,
    int wrong,
    int unAnswered}) {
  return SizedBox(
    width: width * 3.0,
    // height: size.height - 250,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(
                  width > 26 ? '$correct' : '',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                  height: (((size.height - 300) * correct) / total) + 4,
                  width: width,
                  alignment: Alignment.center,
                  // color: Color(0xff365E80),
                  color: Color(0xff4BB543),
                ),
              ],
            ),
//            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  width > 26 ? '$wrong' : '',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                  height: (((size.height - 300) * wrong) / total) + 4,
                  width: width,
                  alignment: Alignment.center,
                  color: Color(0xffFB7483),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  width > 26 ? '$unAnswered' : '',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                Container(
                  height: (((size.height - 300) * unAnswered) / total) + 4,
                  width: width,
                  alignment: Alignment.center,
                  // color: Color(0xffC46E87),
                  color: Color(0xff9BAAB3),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 2),
        SizedBox(
          height: 20,
          child: Text(
            '$title',
            style: TextStyle(color: Colors.black),
          ),
        )
        //
      ],
    ),
  );
}
