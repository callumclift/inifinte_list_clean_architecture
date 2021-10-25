import 'package:get_it/get_it.dart';
import 'package:infinite_list_clean_architecture/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:http/http.dart' as http;

import 'features/posts/data/datasources/posts_data_source.dart';
import 'features/posts/data/datasources/posts_data_source_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';

import 'features/posts/domain/usecases/get_posts.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PostsBloc(
        getPostsUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetPostsUseCase(sl()));

  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(postsDataSource: sl()));

  sl.registerLazySingleton<PostsDataSource>(
      () => PostsDataSourceImpl(client: sl()));

  sl.registerLazySingleton(() => http.Client());
}
