import 'package:infinite_list_clean_architecture/features/posts/data/models/post_model.dart';

abstract class PostsDataSource {
  Future<List<PostModel>> getPostsList([int startIndex = 0]);
}
