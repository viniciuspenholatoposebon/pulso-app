import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/workout.dart';
import '../models/workout_session.dart';

class FirestoreWorkoutDatasource {
  FirestoreWorkoutDatasource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;


  final FirebaseFirestore _firestore;


  CollectionReference<Map<String, dynamic>> _workouts(
    String uid,
  ) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('workouts');
  }


  CollectionReference<Map<String, dynamic>> _sessions(
    String uid,
  ) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('sessions');
  }



  Future<void> saveWorkout({
    required String uid,
    required Workout workout,
  }) async {

    await _workouts(uid)
        .doc(workout.id)
        .set(
          workout.toMap(),
        );
  }



  Future<List<Workout>> getWorkouts(
    String uid,
  ) async {

    final snapshot =
        await _workouts(uid).get();


    return snapshot.docs
        .map(
          (doc) =>
              Workout.fromMap(
                doc.data(),
              ),
        )
        .toList();
  }




  /// Desativa todos os treinos antigos
  /// mantendo apenas o novo plano ativo.
  Future<void> deactivateOldWorkouts(
    String uid,
  ) async {

    final snapshot =
        await _workouts(uid).get();


    final batch =
        _firestore.batch();


    for (final doc in snapshot.docs) {

      final workout =
          Workout.fromMap(
            doc.data(),
          );


      if (workout.isActive) {

        batch.update(
          doc.reference,
          {
            'isActive': false,
            'updatedAt':
                DateTime.now()
                    .millisecondsSinceEpoch,
          },
        );

      }
    }


    await batch.commit();
  }





  Future<void> deleteWorkout({
    required String uid,
    required String workoutId,
  }) async {

    await _workouts(uid)
        .doc(workoutId)
        .delete();
  }




  Future<void> saveWorkoutSession({
    required String uid,
    required WorkoutSession session,
  }) async {

    await _sessions(uid)
        .doc(session.id)
        .set(
          session.toMap(),
        );
  }





  Future<List<WorkoutSession>>
      getWorkoutHistory(
    String uid,
  ) async {

    final snapshot =
        await _sessions(uid)
            .orderBy(
              'startedAt',
              descending: true,
            )
            .get();


    return snapshot.docs
        .map(
          (doc) =>
              WorkoutSession.fromMap(
                doc.data(),
              ),
        )
        .toList();
  }
}