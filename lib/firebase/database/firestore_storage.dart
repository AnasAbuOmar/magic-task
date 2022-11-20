import 'package:cloud_firestore/cloud_firestore.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreStorage {
  static late FirebaseFirestore firestore;

  static void init() {
    firestore = FirebaseFirestore.instance;
  }
}
