import '../../data/models/user_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository repository;

  const UpdateUserProfileUseCase({
    required this.repository,
  });

  Future<void> call(UserProfile profile) {
    return repository.updateProfile(profile);
  }
}
