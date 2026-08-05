import '../../data/models/user_profile.dart';

abstract class ProfileRepository {
  Future<void> saveProfile(UserProfile profile);

  Future<UserProfile?> getProfile(String uid);

  Future<void> updateProfile(UserProfile profile);

  Future<void> deleteProfile(String uid);

  Stream<UserProfile?> profileStream(String uid);
}
