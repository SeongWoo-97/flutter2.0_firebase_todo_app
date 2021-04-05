import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Sign_In/Auth/Auth.dart';
import 'package:firebase_todo_app/Sign_In/SignInPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatefulWidget {
  final User? user;

  SettingPage({this.user});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Auth auth = Auth();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    print(widget.user!.photoURL);
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.user!.photoURL!),
                      minRadius: 30,
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.user!.displayName}',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(
                        '${widget.user!.email}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Text(
                    '설정',
                    style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('로그아웃')
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                  onTap: () async {
                    // await auth.signOut(); // 구글 로그아웃 추가
                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                    await firebaseAuth.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
