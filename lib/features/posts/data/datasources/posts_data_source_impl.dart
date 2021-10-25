import 'dart:convert';

import 'package:infinite_list_clean_architecture/features/posts/data/datasources/posts_data_source.dart';
import 'package:infinite_list_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsDataSourceImpl implements PostsDataSource {
  final http.Client client;

  PostsDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPostsList([int startIndex = 0]) async {
    final response = await client.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '20'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return PostModel.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
