import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:testination/database/closedRoomDatabase.dart';
import 'package:testination/database/openRommDatabase.dart';
import 'package:testination/devtools/dart/devTools.dart';
import 'package:testination/homeScreen/Carousel.dart';
import 'package:testination/homeScreen/drawer/drawer.dart';
import 'package:testination/provider/account.dart';
import 'package:testination/provider/userEventsProvider.dart';
import 'package:testination/screens/closedRoom/closedRoom.dart';
import 'package:testination/screens/openRoom/openRoom.dart';
import 'extracted/extractedContainer.dart';

ThemeData theme;
bool _showSpinner = false;
bool _initialized = false;
List _homeAds = [
  'https://upscmocktest.files.wordpress.com/2015/08/ads-9-examkart-fb.jpg',
  'https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2020/05/12221005/jee-main-mock-test.png'
];

class HomeScreen extends StatefulWidget {
  final user;
  static String id = 'Home_Screen';
  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _showSpinner = false;
    super.initState();
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        print('firebase initialized');
      });
    } catch (e) {
      setState(() {
//        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    double sizedBoxHeight =
        ((MediaQuery.of(context).size.height - 442) / 4) - 20;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(theme.primaryColorDark),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Icon(
                          Icons.menu,
                          size: 35,
                          color: theme.primaryColorDark,
                        ),
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      Spacer(),
                      Text(
                        'Testination',
                        style: TextStyle(
                            color: theme.primaryColorDark,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                      Spacer(),
                      SizedBox(width: 45),
                    ],
                  ),
                ),
              ),
              color: theme.backgroundColor,
            ),
            Container(
              height: 70,
              padding: EdgeInsets.only(left: 25),
              width: double.infinity,
              color: theme.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: GoogleFonts.sairaCondensed(
                      textStyle:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 40),
                      Text(
                        '${Provider.of<MyAccount>(context, listen: false).userDetails['name']}'
                            .toUpperCase(),
                        style: TextStyle(
                            color: theme.accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  SizedBox(
                    height: 193,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: -15,
                          top: 0,
                          width: MediaQuery.of(context).size.width + 15,
                          child: Container(
                            alignment: Alignment.topLeft,
                            color: theme.primaryColor.withOpacity(0.045),
                            width: MediaQuery.of(context).size.width,
                            child: ComplicatedImageDemo(_homeAds),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Color(0xffE1E1E1),
                    elevation: 4,
                    shadowColor: Color(0xffE1E1E1),
                    child: SizedBox(
                      height: 2,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: sizedBoxHeight),
                        Row(
                          children: <Widget>[
                            ExtractedContainer(
                              icon: CupertinoIcons.book,
                              heading: 'Open Room',
                              subHeading: 'Search for test',
                              onClick: () async {
                                _showSpinner = true;
                                setState(() {});
                                await Provider.of<UserEventsProvider>(context,
                                        listen: false)
                                    .getBoughtDetails(context);
                                if (_initialized == true) {
                                  Map data = await getOpenRoomHome();
                                  List searchData = await getSearchData();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OpenRoom(
                                                openRoomData: data,
                                                searchList: searchData,
                                              )));
                                } else {
                                  initializeFlutterFire();
                                }
                                _showSpinner = false;
                                setState(() {});
                              },
                            ),
                            SizedBox(width: 10),
                            ExtractedContainer(
                              icon: CupertinoIcons.pencil,
                              heading: 'Closed Room',
                              subHeading: 'My Subscriptions',
                              onClick: () async {
                                _showSpinner = true;
                                setState(() {});
                                await Provider.of<UserEventsProvider>(context,
                                        listen: false)
                                    .getBoughtDetails(context);
                                List closedRoomData =
                                    Provider.of<UserEventsProvider>(context,
                                            listen: false)
                                        .boughtDetails;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClosedRoomScreen(
                                              closedRoomData: closedRoomData,
                                            )));
                                _showSpinner = false;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: sizedBoxHeight),
                        Row(
                          children: <Widget>[
                            ExtractedContainer(
                              icon: Icons.library_books,
                              heading: 'Services',
                              subHeading: '',
                            ),
                            SizedBox(width: 10),
                            ExtractedContainer(
                              icon: Icons.settings,
                              heading: 'dev tools',
                              subHeading: '',
                              onClick: () async {
//                                setClosedRoom();
//                                addTestingAdminToRaceToUpsc();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DevTools()));
                                // testingAddRaceToUpsc();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: sizedBoxHeight),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
