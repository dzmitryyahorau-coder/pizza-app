import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/stories_repository_interface.dart';

class InmemoryStoriesRepository implements IStoriesRepository {
  final List<Story> _store;

  InmemoryStoriesRepository({List<Story>? store}) : _store = store ?? [];

  @override
  Future<List<Story>> getStories() {
    return Future.syncValue(_store);
  }
}
