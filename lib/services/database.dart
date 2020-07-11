import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/models/information.dart';
import 'package:weather/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection references
  final CollectionReference data = Firestore.instance.collection('profile');

  Future<void> updateUserData(
      String name, String phone, String city) async {
    return await data.document(uid).setData({
      'name': name,
      'phone': phone,
      'city': city,
    });
  }

  //Information from snapshots
  Information _informationFromSnapshot(DocumentSnapshot snapshot) {
    return Information(
      name: snapshot.data['name'] ?? '',
      phone: snapshot.data['phone'] ?? '',
      city: snapshot.data['city'] ?? '',
      email: snapshot.data['email'] ?? '',
    );
  }

  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      phone: snapshot.data['phone'],
      city: snapshot.data['city'],
    );
  }

  //get streams
  Stream<Information> get information {
    return data.document(uid).snapshots().map(_informationFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return data.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
