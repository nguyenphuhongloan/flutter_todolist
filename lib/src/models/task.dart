import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final String subTitle;
  final String content;
  final DateTime deadline;
  final String? urlToImage;
  final String? id;
  Task({
    this.id,
    required this.content,
    required this.deadline,
    required this.subTitle,
    required this.title,
    this.urlToImage,
  });

  factory Task.fromFirebase(dynamic data) {
    
    Timestamp deadlineTS = data['deadline'];
    DateTime deadline = deadlineTS.toDate();
    return Task(
        id: data.id,
        content: data['content'],
        deadline: deadline,
        subTitle: data['subTitle'],
        title: data['title'],
        urlToImage: data['image']);
  }
}
