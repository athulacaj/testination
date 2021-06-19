import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testination/screens/homeScreen/home.dart';

InputDecoration textFieldDecoration = InputDecoration(
    border:
        new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
//  hintText: 'Search for test',
    labelText: 'Search',
    prefixIcon: Icon(Icons.search),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.primaryColorDark, width: 1.0),
    ));
