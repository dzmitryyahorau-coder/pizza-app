import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/stories_repository_interface.dart';

class FirestoreStoriesRepository implements IStoriesRepository {
  final FirebaseFirestore _firestore;

  FirestoreStoriesRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Story> get _collection => _firestore
      .collection('stories')
      .withConverter<Story>(
        fromFirestore: ((snapshot, options) =>
            Story.fromFireStore(snapshot, options)),
        toFirestore: (story, _) => story.toMap(),
      );

  @override
  Future<List<Story>> getStories() async {
    try {
      Query<Story> query = _collection;

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the stories from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreStoriesRepository.getStories(): $e\n$st',
      );
      rethrow;
    }
  }
}
