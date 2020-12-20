import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  final ThemeData theme;
  final String symbol;
  final String title;
  final Color logoColor;
  final bgColor;
  final Function onclick;
  Category(
      {this.symbol,
      this.title,
      this.logoColor,
      this.bgColor,
      this.theme,
      this.onclick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Material(
//        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        elevation: 3,
        child: Container(
          width: (MediaQuery.of(context).size.width - 90) / 3,
          height: (MediaQuery.of(context).size.height) / 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$symbol',
                  style: GoogleFonts.sairaCondensed(
                    textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColorLight,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$title',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.black38, width: 1),
//          borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
