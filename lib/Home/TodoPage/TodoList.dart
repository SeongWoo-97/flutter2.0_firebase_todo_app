import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Home/TodoPage/CreateTodoPage.dart';
import 'package:firebase_todo_app/Home/TodoPage/EditPage.dart';
import 'package:firebase_todo_app/utils/CRUD.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class TodoList extends StatefulWidget {
  final User? user;

  TodoList({this.user});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('작업관리 앱 (Todo App)'),
        centerTitle: true,
      ),
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilderType: PaginateBuilderType.listView, //Change types accordingly
        itemBuilder: (index, context, documentSnapshot) {
          print(documentSnapshot.data()!['title']);
          Timestamp t = documentSnapshot.data()!['createdTime'];
          DateTime d = t.toDate();
          return Card(
            child: ListTile(
              title: Text(documentSnapshot.data()!['title']),
              subtitle: Text('${d.year}년 ${d.month}월 ${d.day}일 ${d.hour}시 ${d.minute}분 ${d.second}초'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => EditTodoPage(documentSnapshot.data()!['id'])));
                      },
                      child: Icon(Icons.edit)),
                  SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        deleteTodo(widget.user, documentSnapshot.data()!['id']);
                      },
                      child: Icon(Icons.delete)),
                ],
              ),
            ),
            margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
          );
        },
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('Todo_List').orderBy('createdTime',descending: true),
        // to fetch real-time data
        isLive: true,
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
