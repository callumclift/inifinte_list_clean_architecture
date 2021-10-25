import 'package:infinite_list_clean_architecture/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel(
      {required int id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String);
  }
}
