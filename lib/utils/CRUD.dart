import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/utils/Todo.dart';
import 'package:firebase_todo_app/utils/Post.dart';

Future<void> createUserDoc(User? user) async {
  if (user != null) {
    FirebaseFirestore.instance.collection("users").doc(user.uid).collection('UserInfo').doc(user.email).set(
      {
        'displayName': user.displayName,
        'email': user.email,
        'emailVerified': user.emailVerified,
        'phoneNumber': user.phoneNumber,
        'uid': user.uid,
      },
    );
  }
}

Future<void> createTodo(User? user, Todo todo) async {
  if (user != null) {
    final docID = FirebaseFirestore.instance.collection("users").doc(user.uid).collection("Todo_List").doc();

    todo.id = docID.id;

    await docID.set(todo.toJson());
  }
}

Future<void> createPost(User? user, Post post) async {
  if (user != null) {
    final docID = FirebaseFirestore.instance.collection("writing").doc();
    post.postId = docID.id;
    await docID.set(post.toJson());
  }
}

Future<void> updateTodo(User? user, Todo todo, String id) async {
  final docTodo = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection('Todo_List').doc(id);
  todo.id = docTodo.id;
  await docTodo.update(todo.toJson());
}

Future<void> deleteTodo(User? user, String id) async {
  await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("Todo_List").doc(id).delete();
}
