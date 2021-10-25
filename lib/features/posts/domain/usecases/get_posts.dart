import 'package:infinite_list_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:infinite_list_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class GetPostsUseCase {
  final PostsRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<Post>> call([int startIndex = 0]) async {
    return repository.getPosts(startIndex);
  }
}
