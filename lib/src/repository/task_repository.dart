import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/models/task.dart';

class TaskRepository {
  Future<bool> createTask(
      {String? title,
      String? subTitle,
      String? content,
      DateTime? deadline,
      String image = ''}) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'subTitle': subTitle,
        'content': content,
        'deadline': deadline,
        'image': image,
        'idUser': FirebaseAuth.instance.currentUser!.uid,
        'status': 0, //0: Doing, 1: done, 2:delete
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> editTask(
      {String? id,
      String? title,
      String? subTitle,
      String? content,
      DateTime? deadline,
      String image = ''}) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(id).update({
        'title': title,
        'subTitle': subTitle,
        'content': content,
        'deadline': deadline,
        'image': image,
        'idUser': FirebaseAuth.instance.currentUser!.uid,
        'status': 0, //0: Doing, 1: done, 2:delete
      });
      uploadImage(image);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> removeTask(String id) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future uploadImage(String image) async {
    File file = File(image);
    await FirebaseStorage.instance.ref('uploads/$image').putFile(file);
    downloadURL(image);
  }

  Future<String> downloadURL(String image) async {
    String downloadURL =
        await FirebaseStorage.instance.ref('uploads/$image').getDownloadURL();
    return downloadURL;
  }
}
