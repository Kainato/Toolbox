import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference phrasesCollection =
      FirebaseFirestore.instance.collection('phrases');

  Stream<QuerySnapshot<Object?>> getPhrases() {
    return phrasesCollection.orderBy('createdAt').snapshots();
  }

  Future<void> addPhrase({
    required String author,
    required String description,
    required String id,
  }) async {
    await phrasesCollection.doc(id.toString()).set(
      {
        'author': author,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
        'id': id,
      },
    );
  }

  Future<void> deletePhrase(String id) async {
    await phrasesCollection.doc(id.toString()).delete();
  }
}
