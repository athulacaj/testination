import 'package:flutter/material.dart';

class DevTools extends StatefulWidget {
  @override
  _DevToolsState createState() => _DevToolsState();
}

class _DevToolsState extends State<DevTools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Dev'),
              Text('√10² ⅔'),
              Text('√10² ⅔  x^8.'),
              Text('⅔'),
            ],
          ),
        ),
      ),
    );
  }
}
