import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Todo.dart';
import 'package:flutter/scheduler.dart';

Future<void> createUserDoc(User? user) async {
  if (user != null) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection('UserInfo')
        .doc(user.email)
        .set(
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

// updateTodo 메서드 수정하기
Future<void> createTodoDoc(User? user, Todo todo) async {
  if (user != null) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection('Todo_List')
        .doc()
        .set(todo.toJson());
  }
  print('createTodoDoc 완료');
}

// 테스트용
Future<void> createTodoDoc2(User? user, String name, String detail) async {
  if (user != null) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection('Todo_List')
        .doc(name)
        .set(
      {
        'name': name,
        'detail': detail,
      },
    );
  }
}

Future<void> deleteTodo(User? user, String name) async {
  FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("Todo_List")
      .doc(name)
      .delete();
}

Future<void> updateTodo(User? user, String name, String detail) async {
  FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("Todo_List")
      .doc(name)
      .update(
    {
      'name': name,
      'detail': detail,
    },
  );
}
