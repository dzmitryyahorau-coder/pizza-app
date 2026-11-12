import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/stories_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'story';

class SupabaseStoriesRepository implements IStoriesRepository {
  @override
  Future<List<Story>> getStories() async {
    final data = await Supabase.instance.client.from(tableName).select();

    final result = data.map((row) => Story.fromMap(row)).toList();

    return result;
  }
}
