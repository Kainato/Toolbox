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
    required int id,
  }) async {
    await phrasesCollection.doc(id.toString()).set(
      {
        'author': author,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
        'id': id,
      },
    );
    // await phrasesCollection.add(
    //   {
    //     'author': author,
    //     'description': description,
    //     // 'id': id,
    //     // 'id': '$id-${phrasesCollection.doc().id}',
    //     'id': phrasesCollection.doc().id,
    //     'createdAt': FieldValue.serverTimestamp(),
    //   },
    // );
  }

  Future<void> deletePhrase(int id) async {
    await phrasesCollection.doc(id.toString()).delete();
  }
}
