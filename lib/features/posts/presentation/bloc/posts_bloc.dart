import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:infinite_list_clean_architecture/features/posts/domain/usecases/get_posts.dart';
import 'package:stream_transform/src/rate_limit.dart';

part 'posts_event.dart';
part 'posts_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase;
  PostsBloc({required this.getPostsUseCase}) : super(const PostsState()) {
    on<PostsFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostFetched(PostsFetched event, Emitter emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostsStatus.initial) {
        List<Post> posts = <Post>[];
        final fetchedPosts = await getPostsUseCase();
        posts.addAll(fetchedPosts);
        return emit(state.copyWith(
          status: PostsStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }

      final posts = await getPostsUseCase(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostsStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostsStatus.failure));
    }
  }
}
