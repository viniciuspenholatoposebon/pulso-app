import '../../domain/repositories/profile_repository.dart';
import '../datasources/firestore_profile_datasource.dart';
import '../models/user_profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirestoreProfileDatasource datasource;

  const ProfileRepositoryImpl(
    this.datasource,
  );

  @override
  Future<void> saveProfile(UserProfile profile) {
    return datasource.saveProfile(profile);
  }

  @override
  Future<UserProfile?> getProfile(String uid) {
    return datasource.getProfile(uid);
  }

  @override
  Future<void> updateProfile(UserProfile profile) {
    return datasource.updateProfile(profile);
  }

  @override
  Future<void> deleteProfile(String uid) {
    return datasource.deleteProfile(uid);
  }

  @override
  Stream<UserProfile?> profileStream(String uid) {
    return datasource.profileStream(uid);
  }
}
