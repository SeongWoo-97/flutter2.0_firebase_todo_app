import 'dart:math';

import 'file:///D:/StudyFolder2/firebase_todo_app/lib/utils/Todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/Sign_In/Auth/Auth.dart';
import 'package:firebase_todo_app/utils/CRUD.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final key = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var detailController = TextEditingController();
  Auth auth = Auth();
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할일 만들기'),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: '이름',
                    hintText: '이름',
                    labelStyle: TextStyle(fontSize: 15),
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  controller: detailController,
                  decoration: InputDecoration(
                    labelText: '상세내용',
                    hintText: '상세내용',
                    labelStyle: TextStyle(fontSize: 15),
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    alignLabelWithHint: true,
                    // maxLines 의 첫줄로 할꺼냐 말꺼냐
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                  maxLines: 4,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Todo todo = Todo(
                    title: nameController.text,
                    description: detailController.text,
                    createdTime: Timestamp.now().toDate(),
                  );
                  await createTodo(auth.firebaseAuth.currentUser, todo);
                  Navigator.pop(context);
                },
                child: Text('만들기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
