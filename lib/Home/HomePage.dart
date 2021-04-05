import 'package:firebase_auth/firebase_auth.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/Home/TodoPage/TodoList.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/Home/Settings/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  List _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      TodoList(user: widget.user),
      SettingPage(user : widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          // title -> label
          BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined), label: '작업관리'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
        onTap: (int index) {
          // 매번 해당페이지의 build 를 불러와야하기 때문에
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_index),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
