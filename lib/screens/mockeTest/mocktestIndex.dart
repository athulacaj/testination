import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/paymentGateway/paymentPage.dart';
import 'package:testination/provider/account.dart';
import 'durationConvertor.dart';
import 'mockTestIno/mockTestInfo.dart';
import 'allIcons.dart';

class MockTestIndex extends StatefulWidget {
  final String heading;
  final Map allData;
  final bool isBought;
  final category;
  final String bundelName;
  MockTestIndex(
      {this.heading,
      this.category,
      this.allData,
      this.bundelName,
      this.isBought});
  @override
  _MockTestIndexState createState() => _MockTestIndexState();
}

class _MockTestIndexState extends State<MockTestIndex> {
  bool _isBought = false;
  @override
  void initState() {
    _isBought = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid =
        Provider.of<MyAccount>(context, listen: false).userDetails['uid'];
    ThemeData theme = Theme.of(context);
    List tests = widget.allData['tests'];
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users/$uid/payments')
              .doc(widget.allData['docId'])
              .snapshots(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              // return progressBar
            } else {
              if (snapshot.data.exists == true) {
                _isBought = true;
              } else {
                _isBought = false;
              }
            }

            return Column(
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
                                '${widget.heading} in ${widget.category.toString().toUpperCase()}',
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
                  itemCount: tests.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          if (tests[i]['free'] == true || _isBought == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MockTestInfo(
                                          testInfo: tests[i],
                                          category: widget.category,
                                          bundlename: widget.heading,
                                          icon: AllIcons().allIcons[i],
                                          name: '${tests[i]['name']}',
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
                                        padding:
                                            const EdgeInsets.only(left: 15),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      ),
                                      tests[i]['free'] == false &&
                                              _isBought == false
                                          ? Container(
                                              decoration: BoxDecoration(
//                                          color: Colors.black.withOpacity(0.1),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.black.withOpacity(0.3),
                                                  Colors.black.withOpacity(0.6)
                                                ]),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6)),
                                              ),
                                            )
                                          : Container(),
                                      tests[i]['free'] == false &&
                                              _isBought == false
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
                                      '${tests[i]['name']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${tests[i]['questions']} Questions',
                                      style: TextStyle(
                                          color: theme.accentColor
                                              .withOpacity(0.6)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        '${secondsConvertor(tests[i]['duration'])}',
                                        style: TextStyle(
                                            color: theme.accentColor
                                                .withOpacity(0.6)))
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
                _isBought == true
                    ? Container()
                    : Container(
                        width: double.infinity,
                        height: 55,
                        color: theme.primaryColor,
                        child: FlatButton(
                          child: Text("Buy Now"),
                          textColor: Colors.white,
//              padding: EdgeInsets.all(16),
                          onPressed: () async {
                            String uid =
                                Provider.of<MyAccount>(context, listen: false)
                                    .userDetails['uid'];

                            Map paymentDetails = {
                              'category': widget.category,
                              'name': widget.heading,
                              'amount': widget.allData['amount'],
                              'uid': uid,
                              'docId': widget.allData['docId']
                            };
                            if (uid != 'null') {
                              // print(paymentDetails);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentPage(paymentDetails),
                                  ));
                            } else {
                              // login error try login again
                            }
                          },
                          color: theme.primaryColor,
                        ),
                      )
              ],
            );
          }),
    );
  }
}
