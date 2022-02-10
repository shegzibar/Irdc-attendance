import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irdc_attendance/model/attend.dart';
import 'package:irdc_attendance/model/user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference attendcollection =
      FirebaseFirestore.instance.collection('attend');

  Future updateuserdata(String name, int attend) async {
    return await attendcollection
        .doc(uid)
        .set({'name': name, 'attend': attend});
  }

  Future updateattend(int attend) async {
    return await attendcollection.doc(uid).update({'attend': attend});
  }

  // user data from snapshot
  UserData _userdatafromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid, name: snapshot.get('name'), attend: snapshot.get('attend'));
  }

  Stream<List<Attend>> get attend {
    return attendcollection.snapshots().map(_attendListsnapshot);
  }

  //list for the attend
  List<Attend> _attendListsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Attend(
          name: doc.get('name') ?? '', attend: doc.get('attend') ?? 0);
    }).toList();
  }

  //get user doc stream
  Stream<UserData> get userData {
    return attendcollection.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}
