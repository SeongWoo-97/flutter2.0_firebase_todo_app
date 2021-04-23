import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String title = 'How to add Border Radius to Container in Flutter ?';
  String contents =
      'So Guys That’s It For How to add Border Radius to Container in Flutter ? Hope you like our tutorial. Comment below Your thoughts and your queries. And Also Comment below your suggestion here.';
  String reply = 'Many times we need to give Border Radius to Container, so i am going to share my code on on how to add Border Radius to a Container.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.refresh),
          SizedBox(width: 10),
          Icon(Icons.menu_outlined),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사진정보 , 닉네임 , 날짜 , 좋아요 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Icon(Icons.person, size: 50),
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('S W'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '04/19 00:21',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {}, child: Text('공감')),
              )
            ],
          ),
          // 제목
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              contents,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.thumb_up_alt_outlined, color: Colors.red, size: 25),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text('0', style: TextStyle(color: Colors.red, fontSize: 20)),
                ),
                Icon(Icons.chat_bubble_outline_outlined, color: Colors.lightBlueAccent, size: 25),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text('0', style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20)),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            indent: 12,
            endIndent: 12,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Icon(Icons.person, size: 25),
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10))),
                    ),
                    Text(
                      '나그네',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(reply),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '04/19 00:21',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
