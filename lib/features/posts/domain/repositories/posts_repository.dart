import 'package:infinite_list_clean_architecture/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts([int startIndex = 0]);
}
