import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testination/brain/brain.dart';
import 'package:testination/provider/userEventsProvider.dart';
import 'package:testination/screens/mockeTest/mocktestIndex.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

// only for dev
void setOpenRoom() async {
  await _firestore
      .collection('openRoom')
      .doc('home')
      .set({'openRoom': openRoom});
}

Future<void> testingAddRaceToUpsc() async {
  await _firestore
      .collection('openRoom')
      .doc('home')
      .set({'openRoom': openRoom});
}

//Future<void> addTestingAdminToRaceToUpsc() async {
//  await _firestore
//      .collection('admin/upsc/G506NcoZP0WNPxLVDq2F8CJI5gD3')
//      .add(adminUPSCRACESOLUTIONS);
//}

Future<Map> getOpenRoomHome() async {
  DocumentSnapshot snapshot =
      await _firestore.collection('openRoom').doc('home').get();
  return snapshot.data()['openRoom'];
}

Future<List<Map>> getSearchData() async {
  List<Map> searchDetails = [];
  QuerySnapshot snapshot =
      await _firestore.collection('admin/questionAddedDetails/admins').get();
  for (DocumentSnapshot snap in snapshot.docs) {
    for (Map test in snap.data()['questionDetails']) {
      // List<Map> toadd = new List<Map>.from(test);
      searchDetails.add(test);
    }
  }
  return searchDetails;
}

Future<void> getDataOFSearchedSelected(
    String category, String id, BuildContext context) async {
  DocumentSnapshot snapshot =
      await _firestore.collection('openRoom/$category/all').doc(id).get();
  Map data = snapshot.data()['allDetails'];
  data['docId'] = snapshot.id;
  Navigator.push(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "/MockTestIndex"),
          builder: (context) => MockTestIndex(
                heading: data['name'],
                category: category,
                allData: data,
              )));
}

Future<List> getIndividualCategoryDataInOpenRoom(
    String category, BuildContext context) async {
  List openRoomData = [];
  List boughtOpenRoomData = [];
  List notBoughtOpenRoomData = [];
  List boughtDetails =
      Provider.of<UserEventsProvider>(context, listen: false).boughtDetails;
  QuerySnapshot snapshots =
      await _firestore.collection('openRoom/$category/all').get();
  List data = [];
//      snapshot.docs;
  if (snapshots.docs == null) {
    return [];
  }
  try {
    for (DocumentSnapshot snapshot in snapshots.docs) {
      Map data = snapshot.data()['allDetails'];
      data['docId'] = snapshot.id;
      bool isBought = checkThisTestBought(boughtDetails, snapshot.id);
      print('is bought $isBought');
      data['isBought'] = isBought;
      if (isBought) {
        boughtOpenRoomData.add(data);
      } else {
        notBoughtOpenRoomData.add(data);
      }
      openRoomData.add(data);
    }

    return [openRoomData, boughtOpenRoomData, notBoughtOpenRoomData];
  } catch (e) {
    return [];
  }
}

Future<bool> getIsBought(String uid, String docId) async {
  bool isBought = false;
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('users/$uid/payments')
      .doc(docId)
      .get();
  if (snapshot.exists) {
    isBought = true;
  }
  return isBought;
}

bool checkThisTestBought(List bought, String docId) {
  for (Map b in bought) {
    if (b['docId'] == docId) {
      return true;
    }
  }
  return false;
}
