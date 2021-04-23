import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Home/Post/PostList.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/Home/TodoPage/TodoList.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/Home/Settings/settings.dart';
import 'package:flutter/material.dart';

// Todo 라는 표준라이브러리가 있기 때문에 다음부턴 조심해서 쓰자
// file:///D:/StudyFolder2/firebase_todo_app/lib/Home/TodoPage/TodoList.dart';

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
      PostList(user: widget.user),
      SettingPage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 안드로이드 뒤로가기 누를시 종료팝업
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            // title -> label , 바뀐점
            BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined), label: '작업관리'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '자유게시판'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
          ],
          onTap: (int index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_index),
        ),
      ),
    );
  }

  // ?? - Null 검사여부
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('종료하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('네'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('아니요'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
