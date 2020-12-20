import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
//only for dev
final FirebaseAuth auth = FirebaseAuth.instance;

Future<Map> getSavedQuestions(
    String category, String name, String test, String uid) async {
  print(uid);
  DocumentSnapshot snapshot = await _firestore
      .collection('userEvents/savedQuestions/${auth.currentUser.uid}')
      .doc('$category$name$test$uid')
      .get();
  return snapshot.data();
}

void deleteSavedQuestions(
    String category, String name, String test, String uid) async {
  print('$category$name$test');
  await _firestore
      .collection('userEvents/savedQuestions/${auth.currentUser.uid}')
      .doc('$category$name$test$uid')
      .delete();
}

void saveQuestionsTimeData(String category, String name, String test,
    List saveQuestiondata, String uid) async {
  print('$category$name$test');
  await _firestore
      .collection('userEvents/savedQuestions/${auth.currentUser.uid}')
      .doc('$category$name$test$uid')
      .set({
    'questionIndex': saveQuestiondata[0],
    'previousIndex': saveQuestiondata[1],
    'answeredList': saveQuestiondata[2],
    'markedList': saveQuestiondata[3],
  });
}
