import 'package:firebase_todo_app/Login/Auth.dart';
import 'package:firebase_todo_app/Login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Auth auth = Auth();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
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
                          NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
                      minRadius: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NickName : 성우'),
                      Text(
                        'Email : oce_ps@naver.com',
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
                        Icons.wb_sunny_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('다크모드')
                    ],
                  ),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(value);
                      });
                    },
                    activeColor: Colors.blueGrey,

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
                    await auth.signOut(); // 구글 로그아웃 추가
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
