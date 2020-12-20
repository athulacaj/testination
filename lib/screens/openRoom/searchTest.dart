import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:testination/utility/textFiledDecoration.dart';

import 'openRoom.dart';

void main() {
  List items = ['a', 'Ad', 'b', 'adc', 'adadd', 'abc'];
  searchItem(items, 'ad');
}

void searchItem(List items, String word) {
  List result = [];
  for (String item in items) {
//    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    final alphanumeric = RegExp('${word.toLowerCase()}');
    bool a = alphanumeric.hasMatch(item);
    if (a == true) {
      print(item);
      result.add(item);
    }
  }
  print(result);
}

List _itemdetails = [];

Widget showSuggestion = Container(
  height: 40,
  child: TypeAheadField(
    hideOnEmpty: true,
    textFieldConfiguration: TextFieldConfiguration(
      autofocus: false,
      onChanged: (value) {},
      textAlign: TextAlign.center,
      decoration: textFieldDecoration.copyWith(
          prefix: SizedBox(width: 50.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColorLight, width: 1.0),
//                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
          )),
    ),
    suggestionsCallback: (pattern) async {
      List suggestionList = getSuggestions(_itemdetails, pattern);
//setState(() {});
      return suggestionList;
    },
    itemBuilder: (context, suggestion) {
      return ListTile(
//                    leading: Icon(Icons.shopping_cart),
        title: Text(suggestion),
//                    subtitle: Text('\$${suggestion['price']}'),
      );
    },
    onSuggestionSelected: (suggestion) {
//this._typeAheadControllerTo.text = suggestion;
      getSuggestions(_itemdetails, suggestion);
//setState(() {});

//              to = suggestion;
    },
  ),
);
