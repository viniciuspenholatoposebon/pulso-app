import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../data/models/user_profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';

final profileControllerProvider =
    StateNotifierProvider<
        ProfileController,
        AsyncValue<UserProfile?>>(
  (ref) {
    return ProfileController(
      getProfileUseCase: GetProfileUseCase(
        repository: ref.watch(
          profileRepositoryProvider,
        ),
      ),
    )..load();
  },
);

class ProfileController
    extends StateNotifier<
        AsyncValue<UserProfile?>> {
  ProfileController({
    required GetProfileUseCase getProfileUseCase,
  })  : _getProfileUseCase =
            getProfileUseCase,
        super(
          const AsyncLoading(),
        );

  final GetProfileUseCase
      _getProfileUseCase;

  Future<void> load() async {
    try {
      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
        state = const AsyncData(null);
        return;
      }

      final profile =
          await _getProfileUseCase(
        user.uid,
      );

      state = AsyncData(
        profile,
      );
    } catch (e, s) {
      state = AsyncError(
        e,
        s,
      );
    }
  }

  Future<void> refresh() async {
    await load();
  }
}