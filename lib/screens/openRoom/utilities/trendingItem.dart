import 'package:flutter/material.dart';

class TrendingItem extends StatelessWidget {
  final Color buttonColor;
  final ThemeData theme;
  TrendingItem({this.buttonColor, this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      child: Stack(
        children: [
          // Container(
          //   height: 200,
          //   width: MediaQuery.of(context).size.width / 2.4,
          //   decoration: BoxDecoration(
          //       border: Border.all(color: buttonColor, width: 10),
          //       borderRadius: BorderRadius.all(Radius.circular(200))),
          // ),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Container(
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
                            height: 80,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'UPSc by Race',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '₹ 50',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))
                                // borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                  width: (MediaQuery.of(context).size.width / 2.4) - 6,
                  height: 160,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    // border:
                    //     Border.all(color: Colors.grey.withOpacity(.2), width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    child: Image(
                      image: AssetImage('assets/test.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
