import 'package:flutter/material.dart';

import 'contentsTabPage.dart';
import 'testTabPage.dart';

class MockTestInfo extends StatefulWidget {
  static String id = 'MockTestInfo';
  final String category;
  final String bundlename;
  final String icon;
  final String name;
  final Map testInfo;
  MockTestInfo(
      {@required this.icon,
      @required this.category,
      this.bundlename,
      this.name,
      this.testInfo});
  @override
  _MockTestInfoState createState() => _MockTestInfoState();
}

class _MockTestInfoState extends State<MockTestInfo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          '${widget.testInfo['name']}',
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: theme.backgroundColor,
            child: TabBar(
              controller: _tabController,
//              unselectedLabelColor: Colors.grey,
//              labelColor: Colors.black,
//              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(
                  text: "Contents",
                ),
                Tab(
                  text: "Test",
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
//            color: Colors.white,
            height: 465,
            child: TabBarView(
//              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                Contents(
                  theme: theme,
                ),
                TestPage(
                  icon: widget.icon,
                  name: widget.name,
                  theme: theme,
                  category: widget.category,
                  bundleName: widget.bundlename,
                  testInfo: widget.testInfo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
