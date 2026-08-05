import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/workout_execution_controller.dart';
import '../widgets/rest_timer.dart';
import 'workout_summary_screen.dart';

class WorkoutExecutionScreen extends ConsumerStatefulWidget {
  const WorkoutExecutionScreen({
    super.key,
  });

  @override
  ConsumerState<WorkoutExecutionScreen> createState() =>
      _WorkoutExecutionScreenState();
}

class _WorkoutExecutionScreenState
    extends ConsumerState<WorkoutExecutionScreen> {
  final Map<String, TextEditingController>
      _weightControllers = {};

  final Map<String, TextEditingController>
      _repsControllers = {};

  bool _showRestTimer = false;

  int _restSeconds = 90;

  TextEditingController _getWeightController(
    String id,
    double value,
  ) {
    return _weightControllers.putIfAbsent(
      id,
      () => TextEditingController(
        text: value.toStringAsFixed(1),
      ),
    );
  }

  TextEditingController _getRepsController(
    String id,
    int value,
  ) {
    return _repsControllers.putIfAbsent(
      id,
      () => TextEditingController(
        text: value.toString(),
      ),
    );
  }

  void _startRestTimer(
    int exerciseIndex,
  ) {
    final seconds = ref
        .read(
          workoutExecutionControllerProvider.notifier,
        )
        .getRestTime(
          exerciseIndex,
        );

    setState(() {
      _restSeconds = seconds;
      _showRestTimer = true;
    });
  }

  void _finishRest() {
    setState(() {
      _showRestTimer = false;
    });
  }

  @override
  void dispose() {
    for (final controller
        in _weightControllers.values) {
      controller.dispose();
    }

    for (final controller
        in _repsControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final session = ref.watch(
      workoutExecutionControllerProvider,
    );

    if (session == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Treino',
          ),
        ),
        body: const Center(
          child: Text(
            'Nenhum treino iniciado.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Treino em andamento',
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: session.exercises.length,
            itemBuilder: (
              context,
              exerciseIndex,
            ) {
              final exercise =
                  session.exercises[exerciseIndex];

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: ExpansionTile(
                  initiallyExpanded:
                      exerciseIndex == 0,
                  title: Text(
                    exercise.exerciseName,
                  ),
                  children:
                      exercise.sets.map(
                    (set) {
                      final id =
                          '${exerciseIndex}_${set.order}';

                      final weightController =
                          _getWeightController(
                        id,
                        set.weight,
                      );

                      final repsController =
                          _getRepsController(
                        id,
                        set.reps,
                      );

                      return Padding(
                        padding:
                            const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              'Série ${set.order}',
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller:
                                        weightController,
                                    enabled:
                                        !set.completed,
                                    keyboardType:
                                        TextInputType.number,
                                    decoration:
                                        const InputDecoration(
                                      labelText:
                                          'Peso kg',
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Expanded(
                                  child: TextField(
                                    controller:
                                        repsController,
                                    enabled:
                                        !set.completed,
                                    keyboardType:
                                        TextInputType.number,
                                    decoration:
                                        const InputDecoration(
                                      labelText:
                                          'Repetições',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            SizedBox(
                              width:
                                  double.infinity,
                              child: FilledButton(
                                onPressed:
                                    set.completed
                                        ? null
                                        : () {
                                            ref
                                                .read(
                                                  workoutExecutionControllerProvider
                                                      .notifier,
                                                )
                                                .completeSet(
                                                  exerciseIndex:
                                                      exerciseIndex,
                                                  setIndex:
                                                      set.order - 1,
                                                  weight:
                                                      double.tryParse(
                                                        weightController.text,
                                                      ) ??
                                                      0,
                                                  reps:
                                                      int.tryParse(
                                                        repsController.text,
                                                      ) ??
                                                      0,
                                                );

                                            _startRestTimer(
                                              exerciseIndex,
                                            );
                                          },
                                child: Text(
                                  set.completed
                                      ? 'Concluído'
                                      : 'Concluir série',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),

          if (_showRestTimer)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: RestTimer(
                seconds:
                    _restSeconds,
                onFinished:
                    _finishRest,
              ),
            ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () async {
          await ref
              .read(
                workoutExecutionControllerProvider
                    .notifier,
              )
              .finishWorkout();

          final updatedSession =
              ref.read(
            workoutExecutionControllerProvider,
          );

          if (!context.mounted ||
              updatedSession == null) {
            return;
          }

          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  WorkoutSummaryScreen(
                session:
                    updatedSession,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.check,
        ),
        label: const Text(
          'Finalizar',
        ),
      ),
    );
  }
}