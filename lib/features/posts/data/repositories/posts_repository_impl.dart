import 'package:infinite_list_clean_architecture/features/posts/data/datasources/posts_data_source.dart';
import 'package:infinite_list_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:infinite_list_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepositoryImpl({required this.postsDataSource});

  @override
  Future<List<Post>> getPosts([int startIndex = 0]) =>
      postsDataSource.getPostsList(startIndex);
}
