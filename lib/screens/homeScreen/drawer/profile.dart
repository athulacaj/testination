import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/screens/auth/phoneAuth/login.dart';

import 'drawer.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<MyAccount>(
      builder: (context, myAccount, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: theme.primaryColorDark,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: theme.primaryColorDark,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                          Spacer(),
                          SizedBox(width: 45),
                        ],
                      ),
                    ),
                  ),
                  color: theme.backgroundColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.profile_circled,
                              size: 100,
                              color: theme.accentColor.withOpacity(0.6)),
                          SizedBox(width: 20),
                          Container(
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${myAccount.userDetails['name']}'
                                    .toUpperCase()),
                                Text('${myAccount.userDetails['email']}'
                                    .toUpperCase()),
                                Text('${myAccount.userDetails['phone']}'
                                    .toUpperCase()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Provider.of<MyAccount>(context, listen: false)
                              .removeUser();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => PhoneLoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                          height: 35,
                          width: 80,
                          alignment: Alignment.center,
                          child: Text('Logout'),
                          decoration: contaionerBlackOutlineButtonDecoration,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
