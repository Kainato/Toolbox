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
    required String source,
    required String id,
  }) async {
    await phrasesCollection.doc(id.toString()).set(
      {
        'author': author,
        'description': description,
        'source': source,
        'createdAt': FieldValue.serverTimestamp(),
        'id': id,
        'likes': 0,
      },
    );
  }

  Future<void> likePhrase({
    required String author,
    required String description,
    required String source,
    required String id,
    required Timestamp? createdAt,
    required int like,
  }) async {
    await phrasesCollection.doc(id.toString()).set(
      {
        //manter os dados anteriores menos o likes
        'author': author,
        'description': description,
        'source': source,
        'createdAt': createdAt,
        'id': id,
        'likes': like,
      },
    );
  }

  Future<void> deletePhrase(String id) async {
    await phrasesCollection.doc(id.toString()).delete();
  }
}
