import 'package:flutter/material.dart';

PreferredSizeWidget commonAppBar(
    {String title, BuildContext context, ThemeData theme}) {
  return AppBar(
    // brightness: Brightness.light,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    title: Text(
      '$title',
      style: TextStyle(color: theme.primaryColorDark),
    ),
    // actions: [
    //   IconButton(
    //     onPressed: () {},
    //     icon: Icon(
    //       Icons.search,
    //       color: Colors.black,
    //     ),
    //   ),
    // ],
  );
}
