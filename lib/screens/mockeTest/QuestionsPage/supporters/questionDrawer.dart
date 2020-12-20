import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themeProvider.dart';

class QuestionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              ModeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration contaionerBlackOutlineButtonDecoration = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.all(Radius.circular(4)),
);

class ModeSwitch extends StatefulWidget {
  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

bool isSwitched = false;

class _ModeSwitchState extends State<ModeSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    isSwitched = themeProvider.isDark();
    ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Text('Dark mode'),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            themeProvider.setTheme(value);
            setState(() {
              isSwitched = value;
              print(isSwitched);
            });
          },
          activeTrackColor: theme.primaryColor,
          activeColor: Colors.greenAccent,
        ),
      ],
    );
  }
}
