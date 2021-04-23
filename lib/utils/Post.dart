import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  DateTime createdTime = Timestamp.now().toDate();
  String writerUid = "";
  String? postId = "";
  String title = "";
  String contents = "";

  Post({required this.createdTime, required this.writerUid, this.postId, required this.title, required this.contents});

  static Post postFromJson(Map<String, dynamic> json) => Post(
        createdTime: toDateTime(json['createdTime']),
        writerUid: json['writerUid'],
        postId: json['postId'],
        title: json['title'],
        contents: json['contents'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': createdTime,
        'writerUid': writerUid,
        'postId': postId,
        'title': title,
        'contents': contents,
      };

  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }
}
