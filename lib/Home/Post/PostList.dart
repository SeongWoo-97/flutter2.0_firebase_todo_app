import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Home/Post/CreatePostPage.dart';
import 'package:firebase_todo_app/Home/Post/PostPage.dart';
import 'package:firebase_todo_app/Home/TodoPage/EditPage.dart';
import 'package:firebase_todo_app/utils/Post.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PostList extends StatefulWidget {
  final User? user;

  PostList({this.user});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유게시판 (개발중)'),
        centerTitle: true,
      ),
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilderType: PaginateBuilderType.listView, //Change types accordingly
        itemBuilder: (index, context, documentSnapshot) {
          Timestamp t = documentSnapshot.data()!['createdTime'];
          DateTime d = t.toDate();
          Post post = Post.postFromJson(documentSnapshot.data()!);

          return Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(documentSnapshot.data()!['title']),
                  SizedBox(height: 5),
                  Text(documentSnapshot.data()!['contents'],style: TextStyle(fontSize: 12,color: Colors.grey),),
                  SizedBox(height: 5),
                ],
              ),
              // subtitle: Text('${d.year}년 ${d.month}월 ${d.day}일 ${d.hour}시 ${d.minute}분 ${d.second}초'),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('5분전 | 익명',style: TextStyle(fontSize: 12,color: Colors.grey),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined,color: Colors.red,size: 15,),
                      SizedBox(width: 5,),
                      Text('3'),
                      SizedBox(width: 5,),
                      Icon(Icons.chat_bubble_outline,color: Colors.lightBlue,size: 15,),
                      SizedBox(width: 5,),
                      Text('3'),
                    ],
                  )
                ],
              ),
              onTap: () {
                Navigator.push((context), MaterialPageRoute(builder: (context) => PostPage()));
              },
            ),
            margin: EdgeInsets.fromLTRB(10, 7, 10, 5),
          );
        },
        // orderBy is compulsory to enable pagination
        // FirebaseFirestore.instance.collection('writing').doc().collection('Todo_List').orderBy('createdTime',descending: true)
        query: FirebaseFirestore.instance.collection('writing').orderBy('createdTime',descending: true),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage()));
            },
          ),
        ),
      ),
    );
  }

}
