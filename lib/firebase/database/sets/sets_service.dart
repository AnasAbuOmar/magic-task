import 'package:magic_task/firebase/database/firestore_storage.dart';
import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:uuid/uuid.dart';

class SetsService {
  CollectionReference sets =
      FirestoreStorage.firestore.collection(collectionName);

  Future<void> createSet({required SetsModel setsModel}) async {
    Uuid id = const Uuid();
    String setsId = id.v1();
    await FirestoreStorage.firestore
        .collection(collectionName)
        .doc(setsId)
        .set({
      'setsId': setsId,
      'workoutId': setsModel.workoutId,
      'numberOfRepetitions': setsModel.numberOfRepetitions,
      'weight': setsModel.weight,
    });
  }

  Future<void> removeSet(
          {  required String setsId}) async =>
      await FirestoreStorage.firestore
          .collection(collectionName)
          .doc(setsId)
          .delete();

// Future<void> updateSet(
//     {required SetsModel setsModel, required String setsId}) async {
//   await FirestoreStorage.firestore
//       .collection(collectionName)
//       .doc(setsId)
//       .update({
//     'setsId': setsId,
//     'workoutId': setsModel.workoutId,
//     'numberOfRepetitions': setsModel.numberOfRepetitions,
//     'weight': setsModel.weight,
//   });
// }
}

const String collectionName = 'sets';
