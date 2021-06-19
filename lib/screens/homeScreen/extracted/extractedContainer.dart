import 'package:flutter/material.dart';

class ExtractedContainer extends StatelessWidget {
  final String heading;
  final String subHeading;
  final IconData icon;
  final Function onClick;
  ExtractedContainer({this.heading, this.subHeading, this.icon, this.onClick});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onClick,
        child: Material(
          elevation: 3,
          color: theme.backgroundColor,
          shadowColor: Color(0xffE1E1E1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
//          width: (MediaQuery.of(context).size.width),

            alignment: Alignment.center,
//                    height: (MediaQuery.of(context).size.height - 141) / 3,
            height: 120,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: theme.primaryColorLight,
                      size: 40,
                    ),
                    Text(
                      heading,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      subHeading,
                      style:
                          TextStyle(color: theme.accentColor.withOpacity(0.5)),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Spacer(),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
