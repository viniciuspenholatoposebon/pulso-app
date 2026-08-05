import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile.dart';

class FirestoreProfileDatasource {
  FirestoreProfileDatasource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<void> saveProfile(UserProfile profile) async {
    await _users.doc(profile.uid).set(
      profile.toMap(),
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<UserProfile?> getProfile(String uid) async {
    final document = await _users.doc(uid).get();

    if (!document.exists) {
      return null;
    }

    final data = document.data();

    if (data == null) {
      return null;
    }

    return UserProfile.fromMap(data);
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _users.doc(profile.uid).update(
      profile.toMap(),
    );
  }

  Future<void> deleteProfile(String uid) async {
    await _users.doc(uid).delete();
  }

  Stream<UserProfile?> profileStream(String uid) {
    return _users.doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      return UserProfile.fromMap(data);
    });
  }
}