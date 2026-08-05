import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/repository_providers.dart';
import '../../../../routes/route_paths.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../controllers/today_workout_controller.dart';
import '../controllers/workout_stats_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/recent_workouts_card.dart';
import '../widgets/stats_grid.dart';
import '../widgets/streak_card.dart';
import '../widgets/today_workout_card.dart';
import '../widgets/weight_chart_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  static const double _horizontalPadding = 20;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final authRepository = ref.read(
      authRepositoryProvider,
    );

    final profile = ref.watch(
      profileControllerProvider,
    );

    final stats = ref.watch(
      workoutStatsControllerProvider,
    );

    final todayWorkout = ref.watch(
      todayWorkoutControllerProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PULSO',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await authRepository.logout();

              if (context.mounted) {
                context.go(
                  RoutePaths.login,
                );
              }
            },
          ),
        ],
      ),
      body: profile.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        data: (user) {
          return stats.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, _) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            data: (workoutStats) {
              return todayWorkout.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                data: (today) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: _horizontalPadding,
                        right: _horizontalPadding,
                        top: 20,
                        bottom: 32,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          HomeHeader(
                            userName:
                                user?.nickname ??
                                'Usuário',
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          StreakCard(
                            currentStreak:
                                workoutStats
                                    .currentStreak,
                            bestStreak:
                                workoutStats.bestStreak,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          TodayWorkoutCard(
                            workoutName:
                                today.workout?.name ??
                                'Dia de descanso',

                            exercises:
                                today.workout
                                        ?.exercises
                                        .length ??
                                    0,

                            estimatedMinutes:
                                today.workout
                                        ?.estimatedDuration ??
                                    0,

                            completed:
                                today.completedToday,

                            restDay:
                                today.workout == null,

                            onStart: () {
                              if (today.workout ==
                                  null) {
                                context.push(
                                  RoutePaths
                                      .trainingGenerator,
                                );
                                return;
                              }

                              context.push(
                                RoutePaths
                                    .workoutDetail,
                                extra:
                                    today.workout,
                              );
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          StatsGrid(
                            weight:
                                user?.weight ?? 0,
                            bmi:
                                user?.bmi ?? 0,
                            bmr:
                                user?.bmr ?? 0,
                            dailyCalories:
                                user?.bmr ?? 0,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          const WeightChartCard(),

                          const SizedBox(
                            height: 20,
                          ),

                          RecentWorkoutsCard(
                            workouts:
                                workoutStats
                                    .recentWorkouts,
                          ),

                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}