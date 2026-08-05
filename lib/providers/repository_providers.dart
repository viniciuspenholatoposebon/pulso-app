import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/profile/data/datasources/firestore_profile_datasource.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/complete_onboarding_usecase.dart';
import '../features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../features/profile/domain/usecases/save_user_profile_usecase.dart';
import '../features/profile/domain/usecases/update_user_profile_usecase.dart';

import '../features/workout/data/datasources/exercise_local_datasource.dart';
import '../features/workout/data/datasources/firestore_workout_datasource.dart';
import '../features/workout/data/repositories/exercise_repository_impl.dart';
import '../features/workout/data/repositories/workout_repository_impl.dart';
import '../features/workout/domain/repositories/exercise_repository.dart';
import '../features/workout/domain/repositories/workout_repository.dart';
import '../features/workout/domain/usecases/get_all_exercises_usecase.dart';
import '../features/workout/domain/usecases/get_workout_history_usecase.dart';
import '../features/workout/domain/usecases/get_workouts_usecase.dart';
import '../features/workout/domain/usecases/save_workout_session_usecase.dart';
import '../features/workout/domain/usecases/save_workout_usecase.dart';

import '../repositories/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';

import 'service_providers.dart';

/// -------------------------------------------------------------------------
/// AUTH
/// -------------------------------------------------------------------------

final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authServiceProvider),
  );
});

/// -------------------------------------------------------------------------
/// PROFILE
/// -------------------------------------------------------------------------

final firestoreProfileDatasourceProvider =
    Provider<FirestoreProfileDatasource>((ref) {
  return FirestoreProfileDatasource();
});

final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    ref.watch(
      firestoreProfileDatasourceProvider,
    ),
  );
});

final getUserProfileUseCaseProvider =
    Provider<GetUserProfileUseCase>((ref) {
  return GetUserProfileUseCase(
    repository: ref.watch(
      profileRepositoryProvider,
    ),
  );
});

final saveUserProfileUseCaseProvider =
    Provider<SaveUserProfileUseCase>((ref) {
  return SaveUserProfileUseCase(
    repository: ref.watch(
      profileRepositoryProvider,
    ),
  );
});

final updateUserProfileUseCaseProvider =
    Provider<UpdateUserProfileUseCase>((ref) {
  return UpdateUserProfileUseCase(
    repository: ref.watch(
      profileRepositoryProvider,
    ),
  );
});

final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>((ref) {
  return CompleteOnboardingUseCase(
    repository: ref.watch(
      profileRepositoryProvider,
    ),
  );
});

/// -------------------------------------------------------------------------
/// EXERCISES
/// -------------------------------------------------------------------------

final exerciseLocalDatasourceProvider =
    Provider<ExerciseLocalDatasource>((ref) {
  return ExerciseLocalDatasource();
});

final exerciseRepositoryProvider =
    Provider<ExerciseRepository>((ref) {
  return ExerciseRepositoryImpl(
    ref.watch(
      exerciseLocalDatasourceProvider,
    ),
  );
});

final getAllExercisesUseCaseProvider =
    Provider<GetAllExercisesUseCase>((ref) {
  return GetAllExercisesUseCase(
    repository: ref.watch(
      exerciseRepositoryProvider,
    ),
  );
});

/// -------------------------------------------------------------------------
/// WORKOUTS
/// -------------------------------------------------------------------------

final firestoreWorkoutDatasourceProvider =
    Provider<FirestoreWorkoutDatasource>((ref) {
  return FirestoreWorkoutDatasource();
});

final workoutRepositoryProvider =
    Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(
    ref.watch(
      firestoreWorkoutDatasourceProvider,
    ),
  );
});

final saveWorkoutUseCaseProvider =
    Provider<SaveWorkoutUseCase>((ref) {
  return SaveWorkoutUseCase(
    repository: ref.watch(
      workoutRepositoryProvider,
    ),
  );
});

final getWorkoutsUseCaseProvider =
    Provider<GetWorkoutsUseCase>((ref) {
  return GetWorkoutsUseCase(
    repository: ref.watch(
      workoutRepositoryProvider,
    ),
  );
});

final saveWorkoutSessionUseCaseProvider =
    Provider<SaveWorkoutSessionUseCase>((ref) {
  return SaveWorkoutSessionUseCase(
    repository: ref.watch(
      workoutRepositoryProvider,
    ),
  );
});

final getWorkoutHistoryUseCaseProvider =
    Provider<GetWorkoutHistoryUseCase>((ref) {
  return GetWorkoutHistoryUseCase(
    repository: ref.watch(
      workoutRepositoryProvider,
    ),
  );
});