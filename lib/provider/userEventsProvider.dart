import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testination/provider/account.dart';

class UserEventsProvider with ChangeNotifier {
  List boughtDetails = [];
  Future getBoughtDetails(context) async {
    boughtDetails = await getClosedRoomData(context);
    notifyListeners();
  }
}

Future<List> getClosedRoomData(context) async {
  String uid = Provider.of<MyAccount>(context, listen: false).uid;
  List<Map> closedRoomData = [];
  Future.delayed(Duration(milliseconds: 100));

  QuerySnapshot snapshots =
      await FirebaseFirestore.instance.collection('users/$uid/bought').get();

  print(snapshots.docs);
  if (snapshots.docs == null) {
    return [];
  }
  try {
    for (DocumentSnapshot snapshot in snapshots.docs) {
      Map data = snapshot.data()['allDetails'];
      data['docId'] = snapshot.id;
      print('doc details $data');
      closedRoomData.add(data);
    }
    print("data : $closedRoomData");

    return closedRoomData;
  } catch (e) {
    return [];
  }

  //
  for (var snapshot in snapshots.docs) {
    closedRoomData.add(snapshot.data());
  }
  return closedRoomData;
}
