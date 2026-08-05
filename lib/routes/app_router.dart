import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/profile/presentation/screens/onboarding_screen.dart';
import '../features/workout/data/models/workout.dart';
import '../features/workout/presentation/screens/training_generator_screen.dart';
import '../features/workout/presentation/screens/workout_detail_screen.dart';
import '../features/workout/presentation/screens/workout_history_screen.dart';
import '../providers/repository_providers.dart';
import 'notifiers/auth_notifier.dart';
import 'route_paths.dart';


final appRouterProvider =
    Provider<GoRouter>((ref) {

  final authNotifier = AuthNotifier(
    ref.watch(
      authRepositoryProvider,
    ),
  );


  ref.onDispose(
    authNotifier.dispose,
  );


  return GoRouter(

    initialLocation:
        RoutePaths.login,


    refreshListenable:
        authNotifier,


    redirect: (
      context,
      state,
    ) {

      final loggedIn =
          authNotifier.isLoggedIn;


      final location =
          state.matchedLocation;


      if (!loggedIn &&
          location != RoutePaths.login) {
        return RoutePaths.login;
      }


      if (loggedIn &&
          location == RoutePaths.login) {
        return RoutePaths.onboarding;
      }


      return null;
    },


    routes: [

      GoRoute(
        path:
            RoutePaths.login,

        builder:
            (
          context,
          state,
        ) =>
            const LoginScreen(),
      ),


      GoRoute(
        path:
            RoutePaths.onboarding,

        builder:
            (
          context,
          state,
        ) =>
            const OnboardingScreen(),
      ),


      GoRoute(
        path:
            RoutePaths.home,

        builder:
            (
          context,
          state,
        ) =>
            const HomeScreen(),
      ),


      GoRoute(
        path:
            RoutePaths.trainingGenerator,

        builder:
            (
          context,
          state,
        ) =>
            const TrainingGeneratorScreen(),
      ),


      GoRoute(
        path:
            RoutePaths.workoutDetail,

        builder:
            (
          context,
          state,
        ) {

          final workout =
              state.extra as Workout;


          return WorkoutDetailScreen(
            workout:
                workout,
          );
        },
      ),


      GoRoute(
        path:
            RoutePaths.workoutHistory,

        builder:
            (
          context,
          state,
        ) =>
            const WorkoutHistoryScreen(),
      ),
    ],
  );
});