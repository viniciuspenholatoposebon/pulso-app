import '../../data/models/user_profile.dart';
import '../repositories/profile_repository.dart';

class SaveUserProfileUseCase {
  final ProfileRepository repository;

  const SaveUserProfileUseCase({
    required this.repository,
  });

  Future<void> call(UserProfile profile) {
    return repository.saveProfile(profile);
  }
}
