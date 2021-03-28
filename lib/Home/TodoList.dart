import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Home/CreateTodoPage.dart';
import 'package:flutter/material.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  User? user;

  _HomePageState(this.user);

  @override
  void initState() {
    super.initState();
    print(user!.email);
  }

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
            return Text("Loading");
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1.5,
            ),
            itemBuilder: (context, index) {
              print(index);
              return ListTile(
                title: Text(snapshot.data!.docs[index]['title']),
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
