import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference phrasesCollection =
      FirebaseFirestore.instance.collection('phrases');

  Stream<QuerySnapshot<Object?>> getPhrases() {
    return phrasesCollection.snapshots();
  }

  Future<void> addPhrase(String description) async {
    await phrasesCollection.add({
      'description': description,
    });
  }
}
