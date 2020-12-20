import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveUserData(Map userData) async {
  final localData = await SharedPreferences.getInstance();

  String user = jsonEncode(userData);
  localData.setString('user', user);
}

void deleteUserData() async {
  final localData = await SharedPreferences.getInstance();
  localData.remove('user');
}

class MyAccount with ChangeNotifier {
  String uid = 'null';
  Map userDetails;
  void setUid(String uidi) {
    uid = uidi;
    notifyListeners();
  }

  void addUser(Map user) async {
    userDetails = user;
    saveUserData(user);
    notifyListeners();
  }

  void removeUser() async {
    deleteUserData();
    notifyListeners();
  }

  Future<Map> getUserData() async {
    final localData = await SharedPreferences.getInstance();
    String userData = localData.getString('user') ?? '';
    if (userData == "null" || userData == '') {
    } else {
      userDetails = jsonDecode(userData);
      return userDetails;
      notifyListeners();
    }
    return null;
  }
}
