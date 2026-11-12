import 'package:pizza_app/features/menu/data/models/story.dart';

abstract interface class IStoriesRepository {
  Future<List<Story>> getStories();
}
