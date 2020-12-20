import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/submit/LeaderBoard/divideAndConq.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/submit/resultTab/resultTab.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
//only for dev
final FirebaseAuth auth = FirebaseAuth.instance;

List<Map> _savedResult = [];
String _docId;
String _uid;

Future saveResultToDataBase(String docId, Map resultData, String uid) async {
  print('result data $resultData');
  _docId = docId;
  _uid = uid;
  var data = await getResultFromDataBase(docId, uid);
  _savedResult = [];
  if (data != null) {
    _savedResult = List<Map>.from(data['list']);
  }
  _savedResult.add(resultData);
  await _firestore
      .collection('userEvents/questionsResult/${auth.currentUser.uid}')
      .doc('$docId$uid')
      .set({'list': _savedResult});
}

Future getResultFromDataBase(String docId, String uid) async {
  Map resultMap = await _firestore
      .collection('userEvents/questionsResult/${auth.currentUser.uid}')
      .doc('$docId$uid')
      .get()
      .then((value) => value.data())
      .catchError((e) => print(e));
  return resultMap;
}

saveDataToLeaderBoard(String docId, String uid, int total, Map accountDetails) {
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('userEvents/leaderBoard/$docId')
      .doc(uid);

  return _firestore
      .runTransaction((transaction) async {
        // Get the document
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        int highestMark;
        if (!snapshot.exists) {
          highestMark = total;
          transaction.set(documentReference, {
            'score': total,
            'name': accountDetails['name'],
            'uid': uid,
          });

          // throw Exception("User does not exist!");
        } else {
          // List varList = snapshot.data()['list'];
          int highScore = total > snapshot.data()['score']
              ? total
              : snapshot.data()['score'];

          // int a =
          // addToSortedListIndex(0, list.length - 1, list, 0, total, false);
          // print(list);

          if (highScore > snapshot.data()['score']) {
            transaction.update(documentReference, {
              'score': highScore,
              'name': accountDetails['name'],
              'uid': uid
            });
          }
        }
        return total;
      })
      .then((value) {
        print("coin count updated to $value");
      })
      .then((value) {})
      .catchError((error) => print("Failed to update user followers: $error"));
}
