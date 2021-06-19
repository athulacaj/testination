import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:testination/database/openRommDatabase.dart';
import 'package:testination/screens/individualCategory/individualCategory.dart';
import 'package:testination/screens/mockeTest/mocktestIndex.dart';
import 'package:testination/utility/constants.dart';
import 'package:testination/utility/textFiledDecoration.dart';
import 'package:testination/utility/widgets/commonAppBar.dart';

import 'utilities/category.dart';
import 'utilities/trendingItem.dart';

ThemeData theme;
List<Map> _searchItems = [];

class OpenRoom extends StatefulWidget {
  final Map openRoomData;
  final List searchList;
  OpenRoom({this.openRoomData, this.searchList});
  @override
  _OpenRoomState createState() => _OpenRoomState();
}

TextEditingController _typeAheadController = TextEditingController();
SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
List _itemdetails = [];
FocusNode _focus = new FocusNode();
bool _shopAppBar = true;
bool _showSpinner = false;

class _OpenRoomState extends State<OpenRoom> {
  @override
  void initState() {
    _shopAppBar = true;
    _focus.addListener(_onFocusChange);
    _showSpinner = false;
    super.initState();
  }

  void _onFocusChange() {
//    debugPrint("Focus: " + _focus.hasFocus);
    if (_focus.hasFocus == true) {
      _shopAppBar = false;
      setState(() {});
    } else {
      _shopAppBar = true;
      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(theme.primaryColorDark),
      ),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        // backgroundColor: Colors.green,
        body: Column(
          children: <Widget>[
            // _shopAppBar
            //     ? commonAppBar(
            //         context: context, title: 'Open Room', theme: theme)
            //     : SafeArea(child: Container()),
            // SizedBox(height: 30),
            SafeArea(
              child: Material(
                elevation: 3,
                child: Container(
                  height: 140,
                  color: theme.appBarTheme.color,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        height: _shopAppBar ? 50 : 0,
                        // width: _shopAppBar ? size.width : 0,
                        duration: Duration(milliseconds: 400),
                        child: _shopAppBar
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back),
                                      padding: EdgeInsets.all(0),
                                    ),
                                    SizedBox(width: 18),
                                    Text(
                                      'Open Room',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: theme.primaryColorDark,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: 28, vertical: 10),
                        padding: EdgeInsets.all(8),
                        height: 70,
                        child: Row(
                          children: [
                            !_shopAppBar
                                ? IconButton(
                                    onPressed: () {
                                      _shopAppBar = true;
                                      _focus.unfocus();
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    padding: EdgeInsets.all(0),
                                  )
                                : SizedBox(width: 32),
                            Container(
                              width: size.width - 64,
                              color: Colors.white,
                              child: TypeAheadField(
//                      hideOnEmpty: true,
                                  suggestionsBoxController:
                                      _suggestionsBoxController,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _typeAheadController,
                                    focusNode: _focus,
                                    autofocus: false,
                                    textAlign: TextAlign.center,
                                    decoration: textFieldDecoration.copyWith(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          _typeAheadController.clear();
                                          _suggestionsBoxController.close();
                                        },
                                      ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    List<Map> suggestionList = getSuggestions(
                                        widget.searchList, pattern);
                                    return suggestionList;
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
//                          leading: Icon(Icons.collections_bookmark),
                                      title: Material(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 55,
                                                    color:
                                                        theme.primaryColorDark,
                                                    child: Text(
                                                      suggestion['category']
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(suggestion['name'] +
                                                  ' by ' +
                                                  suggestion['author']),
                                              SizedBox(height: 4),
                                            ],
                                          ),
                                        ),
                                      ),
//                    subtitle: Text('\$${suggestion['price']}'),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) async {
                                    _showSpinner = true;
                                    setState(() {});
                                    await getDataOFSearchedSelected(
                                        suggestion['category'],
                                        suggestion['id'],
                                        context);
                                    _showSpinner = false;
                                    setState(() {});
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  SizedBox(height: 0),
                  // search

                  Padding(
                    padding: const EdgeInsets.all(KDefaultPadding),
                    child: Material(
                      elevation: 3,
                      child: Container(
                        // padding: const EdgeInsets.only(
                        //     left: 20, right: 20, top: 15, bottom: 15),
                        padding: EdgeInsets.all(14),
                        color: theme.backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Categories',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 20),
                            GridView.builder(
                              padding: EdgeInsets.all(5),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  widget.openRoomData['categories'].length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:
                                          size.width / (size.height / 2.2),
                                      crossAxisSpacing: size.width / 20,
                                      mainAxisSpacing: size.width / 20,
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {
                                String category =
                                    widget.openRoomData['categories'][index];
                                return Category(
                                  symbol: '$category'.substring(0, 1),
                                  theme: theme,
                                  title: '$category',
                                  logoColor: Color(0xff8D68F1),
                                  bgColor: Color(0xff8D68F1).withOpacity(0.05),
                                  onclick: () async {
                                    _showSpinner = true;
                                    setState(() {});
                                    List individualDatalist =
                                        await getIndividualCategoryDataInOpenRoom(
                                            category.toLowerCase(), context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IndividualCategory(
                                            title: category,
                                            category: category,
                                            individualDatalist:
                                                individualDatalist,
                                          ),
                                        ));
                                    _showSpinner = false;
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Divider(),

                  SizedBox(height: 10),
                  //trending
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: KDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Trending',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              int i = index <= 4 ? index : index - 5;
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 0, left: 14),
                                child: TrendingItem(
                                  theme: theme,
                                  buttonColor: buttonColors[i],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color button1 = Color(0xff6BCAE2);
Color button2 = Color(0xffFFC75E);
Color button3 = Color(0xff87E293);
Color button4 = Color(0xff51A5BA);
Color button5 = Color(0xffFE8402);
List<Color> buttonColors = [button1, button2, button3, button4, button5];

List<Map> getSuggestions(List itemsList, String searchWordAllCase) {
  List<Map> _result = [];

  List<Map> allItems = itemsList;
  _result = [];
  if (searchWordAllCase == '') {
    return itemsList;
  }
  String searchWord = searchWordAllCase.toLowerCase();
  int i = 0;
  for (Map itemString in allItems) {
    String name = itemString['name'].toLowerCase();
    String item =
        '$name in ${itemString['category'].toLowerCase()} by ${itemString['author'].toLowerCase()}';

    String catAuthor =
        '${itemString['category'].toLowerCase()} ${itemString['author'].toLowerCase()}';
    String authorCat =
        '${itemString['author'].toLowerCase()} ${itemString['category'].toLowerCase()}';
    String authorCat1 =
        '${itemString['author'].toLowerCase().split(' ')[0]} ${itemString['category'].toLowerCase()}';

    List reversedItemList = itemString['name'].toLowerCase().split(' ');
    String reverseditem = reversedItemList.reversed.join(' ');
    final alphanumeric = RegExp('$searchWord');
    List itemList = item.split(' ');
    List reversedList = reverseditem.split(' ');
    bool a = alphanumeric.hasMatch(item);
    bool b = alphanumeric.hasMatch(reverseditem);
    bool c = alphanumeric.hasMatch(catAuthor);
    bool d = alphanumeric.hasMatch(authorCat);
    bool e = alphanumeric.hasMatch(authorCat1);

    if (a == true || b == true || c == true || d == true || e == true) {
      _result.add(itemString);
    } else {}
    i++;
  }
//   if (searchWord == '') {
//     Map categoryMap = {'route': 'null', 'display': 'enter key words !'};
//     _result.add(categoryMap);
//    _showSearch = false;
//   }

  return _result;
}

// class SearchItems {
//   List categories = ['UPSC', 'KPSC', 'IAS', 'JEE', 'NEET', 'GATE'];
//   List testProviders = ['Race', 'Ace', 'Testination'];
//   getData() {
//     for (var category in categories) {
//       Map categoryMap = {'route': 'category', 'display': '$category'};
//       _searchItems.add(categoryMap);
//       for (var provider in testProviders) {
//         Map categoryMap = {
//           'route': 'tests',
//           'display': '$category by $provider'
//         };
//         _searchItems.add(categoryMap);
//       }
//     }
//   }
// }
