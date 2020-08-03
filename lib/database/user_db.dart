import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid});

  //collection reference
  final CollectionReference userinfoCollection = Firestore.instance.collection('UserInfo');
  Future updateUserData( String name, String email, String phoneNumber) async {
    return await userinfoCollection.document(uid).setData({
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
    });
  }


  // get data stream
  Stream<QuerySnapshot> get data {
    return userinfoCollection.snapshots();
  }


}