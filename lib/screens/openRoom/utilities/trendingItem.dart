import 'package:flutter/material.dart';

class TrendingItem extends StatelessWidget {
  final Color buttonColor;
  final ThemeData theme;
  TrendingItem({this.buttonColor, this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//          Icon(
//            CupertinoIcons.create,
//            size: 70,
//          ),
              Spacer(),
              Container(
                height: 50,
                child: Image(
                  image: AssetImage('assets/test.png'),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'UPSc by Race',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Container(
                height: 40,
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  '₹ 50',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(.2), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(color: Colors.grey.withOpacity(.2), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
