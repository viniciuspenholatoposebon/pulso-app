import '../repositories/profile_repository.dart';
import '../../data/models/user_profile.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  const GetProfileUseCase({
    required this.repository,
  });

  Future<UserProfile?> call(
    String uid,
  ) {
    return repository.getProfile(uid);
  }
}