import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../qusetionAnswerProvider.dart';
import 'LeaderBoard/leaderBoard.dart';
import 'compare/compareTab.dart';
import 'resultTab/resultTab.dart';

class SubmitPage extends StatefulWidget {
  final List<dynamic> questionsAndAnswers;
  final String documentId;
  SubmitPage({@required this.questionsAndAnswers, @required this.documentId});
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // init called once is from result tab ,this is to save data one time
    initCalledOnce = false;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(
          ModalRoute.withName("/MockTestIndex"),
        );

        await Future.delayed(Duration(milliseconds: 300));
//        Provider.of<QuestionAnswersProvider>(context, listen: false).submit();
        return new Future(() => false);
      },
      child: Scaffold(
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
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            ),
                            onTap: () async {
                              Navigator.of(context).popUntil(
                                ModalRoute.withName("/MockTestIndex"),
                              );
                              await Future.delayed(Duration(milliseconds: 300));
                              Provider.of<QuestionAnswersProvider>(context,
                                      listen: false)
                                  .submit();
                            },
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Result Page',
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
              color: theme.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TabBar(
//              indicatorColor: Colors.black,
//              unselectedLabelColor: Colors.grey,

                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: 'Result',
                  ),
                  Tab(
                    text: 'Compare',
                  ),
                  Tab(
                    text: 'Leader Board',
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ResultTabPage(
                        questionsAndAnswers: widget.questionsAndAnswers,
                        docId: widget.documentId,
                      ),
                      CompareTab(docId: widget.documentId),
                      LeaderBoard(docId: widget.documentId),
                    ],
                  ),
                  decoration: BoxDecoration(
//                  color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
