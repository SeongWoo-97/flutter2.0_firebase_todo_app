import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/CRUD.dart';
import 'package:firebase_todo_app/Home/CreateTodoPage.dart';
import 'package:firebase_todo_app/Home/EditPage.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final User? user;

  TodoList({this.user});

  @override
  _TodoListState createState() => _TodoListState(user);
}

class _TodoListState extends State<TodoList> {
  User? user;

  _TodoListState(this.user);

  @override
  Widget build(BuildContext context) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('Todo_List');
    return Scaffold(
      appBar: AppBar(
        title: Text('작업관리 앱 (Todo App)'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collection.orderBy('createdTime', descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Text(
              "Loading",
              style: TextStyle(fontSize: 30),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data!.docs[index]['title']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => EditTodoPage(snapshot.data!.docs[index]['id'])));
                          },
                          child: Icon(Icons.edit)),
                      SizedBox(
                        width: 5,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            deleteTodo(user, snapshot.data!.docs[index]['id']);
                          },
                          child: Icon(Icons.delete)),
                    ],
                  ),
                ),
                margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        width: 70,
        height: 100,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTodoPage()));
            },
          ),
        ),
      ),
    );
  }
}
