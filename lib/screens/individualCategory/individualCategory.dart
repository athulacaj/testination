import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:provider/provider.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/mockeTest/mocktestIndex.dart';
import 'package:testination/utility/constants.dart';
import 'package:testination/utility/widgets/commonAppBar.dart';

import 'fliterMenuButton.dart';

List _unBoughtIndividualList = [];
List _boughtIndividualList = [];
bool _loaded = false;

class IndividualCategory extends StatefulWidget {
  final String title;
  final List individualDatalist;
  final String category;
  IndividualCategory({
    this.title,
    this.individualDatalist,
    this.category,
  });
  @override
  _IndividualCategoryState createState() => _IndividualCategoryState();
}

class _IndividualCategoryState extends State<IndividualCategory> {
  String selectedFilter = 'All';
  List allIndividualList = [];
  @override
  void initState() {
    resetData();
    selectedFilter = 'All';
    super.initState();
  }

  void resetData() {
    allIndividualList = widget.individualDatalist[0];
    _unBoughtIndividualList = [];
    _boughtIndividualList = [];
    _loaded = false;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    ThemeData theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    String uid =
        Provider.of<MyAccount>(context, listen: false).userDetails['uid'];

    return Scaffold(
      appBar: commonAppBar(
          title: widget.title.toString(), context: context, theme: theme),
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: theme.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    return await showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: size.width,
                            height: 250,
                            color: Colors.redAccent,
                            child: Material(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: theme.backgroundColor,
                                        width: size.width - 50,
                                        height: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 40),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Filter Menu',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 15),
                                                  FilterButton(
                                                    title: 'All',
                                                    selectedFilter:
                                                        selectedFilter,
                                                    onClick: () {
                                                      allIndividualList = widget
                                                          .individualDatalist[0];
                                                      Navigator.pop(context);
                                                      print(selectedFilter);
                                                      // selectedFilter = 'All';
                                                    },
                                                  ),
                                                  FilterButton(
                                                    title: 'Not Bought',
                                                    selectedFilter:
                                                        selectedFilter,
                                                    onClick: () {
                                                      selectedFilter =
                                                          'Not Bought';
                                                      allIndividualList = widget
                                                          .individualDatalist[2];
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  FilterButton(
                                                    title: 'Bought',
                                                    selectedFilter:
                                                        selectedFilter,
                                                    onClick: () {
                                                      selectedFilter = 'Bought';
                                                      allIndividualList = widget
                                                          .individualDatalist[1];
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).then((val) {
                      print('dialog closed');
                      setState(() {});
                    });
                  },
                  child: Material(
                    color: theme.buttonColor,
                    elevation: 2,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 160,
                      padding: EdgeInsets.all(4),
                      // width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Filter: $selectedFilter',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(KDefaultPadding - 3),
            child: SizedBox(
              height: size.height - 165,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: allIndividualList.length,
                padding: EdgeInsets.only(left: 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (size.width - KDefaultPadding * 3) / 330,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemBuilder: (BuildContext context, int index) {
                  Map data = allIndividualList[index];
                  String name = data['name'].toString().toLowerCase();
                  return ItemCard(
                    data: data,
                    widget: widget,
                    theme: theme,
                    isBought: data['isBought'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Map data;
  final widget;
  final theme;
  final isBought;
  ItemCard({this.data, this.widget, this.theme, this.isBought});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "/MockTestIndex"),
                  builder: (context) => MockTestIndex(
                        heading: data['name'],
                        category: widget.category,
                        allData: data,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(CupertinoIcons.book, size: 40),
                          Spacer(),
//                                            Text(
//                                                '${totalLikesRatings[name]['rating'] ?? 5}'),
                          Icon(Icons.star,
                              size: 20,
                              color: Colors.orangeAccent.withOpacity(0.5)),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    Text(
                      '${data['name']}',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(height: 3),
                    Text('by ${data['author']}'),
                    Row(
                      children: <Widget>[
                        Icon(CupertinoIcons.heart,
                            color: Colors.redAccent, size: 32),
                        SizedBox(width: 4),
//                                          Text(
//                                              '${totalLikesRatings[name]['likes'] ?? 0}'),
                      ],
                    ),
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
                  width: MediaQuery.of(context).size.width / 4,
                  height: 30,
                  child: Text(
                    isBought == true ? 'Bought' : '₹ ${data['amount']}',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
