import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Sign_In/Auth/Auth.dart';
import 'package:firebase_todo_app/utils/CRUD.dart';
import 'package:firebase_todo_app/utils/Post.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  final User? user;

  CreatePostPage({this.user});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final key = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var contentsController = TextEditingController();

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
                  controller: contentsController,
                  decoration: InputDecoration(
                    labelText: '내용',
                    hintText: '내용',
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
                  Post post = Post(
                    createdTime: Timestamp.now().toDate(),
                    writerUid: auth.firebaseAuth.currentUser!.uid,
                    title: nameController.text,
                    contents: contentsController.text,
                  );
                  await createPost(auth.firebaseAuth.currentUser, post);
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
