import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart' as dependancyInjection;
import '../bloc/posts_bloc.dart';
import '../widgets/posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider<PostsBloc>(
        create: (_) => dependancyInjection.sl<PostsBloc>()..add(PostsFetched()),
        child: const PostsList(),
      ),
    );
  }
}
