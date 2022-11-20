import 'package:magic_task/firebase/database/firestore_storage.dart';
import 'package:magic_task/firebase/database/workout/workout.dart';
import 'package:magic_task/firebase/database/workout/workout_model.dart';
import 'package:uuid/uuid.dart';

class WorkoutService {
  CollectionReference workout =
      FirestoreStorage.firestore.collection(collectionName);

  Future<String> createWorkout({required WorkoutModel workoutModel}) async {
    try {
      Uuid id = const Uuid();
      String workoutId = id.v1();
      await FirestoreStorage.firestore
          .collection(collectionName)
          .doc(workoutId)
          .set({
        'workoutId': workoutId,
        'workoutName': workoutModel.workoutName,
        'numberOfSets': workoutModel.numberOfSets,
        'createAt': DateTime.now(),
      });
      return workoutId;
    } catch (e) {
      return '';
    }
  }

  Future<void> updateWorkout({required WorkoutModel workoutModel}) async {
    Uuid id = const Uuid();
    String workoutId = id.v1();
    await FirestoreStorage.firestore
        .collection(collectionName)
        .doc(workoutId)
        .update({
      'workoutId': workoutId,
      'workoutName': workoutModel.workoutName,
      'numberOfSets': workoutModel.numberOfSets,
    });
  }
}

const String collectionName = 'workout';

enum Status {
  success,
  error,
}
