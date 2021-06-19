import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/auth/phoneAuth/login.dart';
import 'package:testination/screens/homeScreen/drawer/profile.dart';
import 'package:testination/themeProvider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Icon(CupertinoIcons.profile_circled,
                      size: 80, color: theme.accentColor.withOpacity(0.6)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 60,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text(
                          '${Provider.of<MyAccount>(context, listen: false).userDetails['name']}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text('My profile'),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Icon(Icons.arrow_forward_ios,
                        size: 15, color: theme.accentColor.withOpacity(0.5)),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            Divider(
              color: theme.accentColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.brightness_4),
                      SizedBox(width: MediaQuery.of(context).size.width / 8),
                      ModeSwitch(),
                    ],
                  ),
                  SizedBox(height: 15),
                  buildRow(Icons.graphic_eq, 'Analytics', context),
                  SizedBox(height: 25),
                  buildRow(Icons.calendar_today, 'Calender', context),
                  SizedBox(height: 25),
                  buildRow(Icons.notifications, 'Notifications', context),
                  SizedBox(height: 25),
                  buildRow(Icons.settings, 'Settings', context),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(IconData icon, String title, BuildContext context) {
  return Row(
    children: <Widget>[
      Icon(icon),
      SizedBox(width: MediaQuery.of(context).size.width / 8),
      Text('$title', style: _drawerTextStyle),
    ],
  );
}

TextStyle _drawerTextStyle = TextStyle(fontSize: 17);

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
        Text(
          'Dark mode',
          style: _drawerTextStyle,
        ),
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
