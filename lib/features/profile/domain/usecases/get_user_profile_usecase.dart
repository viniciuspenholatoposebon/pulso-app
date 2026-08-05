import '../repositories/profile_repository.dart';
import '../../data/models/user_profile.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  const GetUserProfileUseCase({
    required this.repository,
  });

  Future<UserProfile?> call(String uid) {
    return repository.getProfile(uid);
  }
}
