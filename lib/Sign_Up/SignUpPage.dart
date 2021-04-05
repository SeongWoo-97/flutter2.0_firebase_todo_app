import 'package:firebase_todo_app/Sign_In/Auth/Auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class ValidationMixin {
  String? validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 4) {
      return 'Enter 4 more char';
    }
    return null;
  }
}

class _SignUpPageState extends State<SignUpPage> with ValidationMixin{
  final globalKey = GlobalKey<FormState>();
  var id = TextEditingController();
  var pw1 = TextEditingController();
  var pw2 = TextEditingController();
  bool _showPW1 = true;
  bool _showPW2 = true;
  Auth auth = new Auth();

  @override
  void dispose() {
    id.dispose();
    pw1.dispose();
    pw2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset(
                'images/firebase.png',
                width: (width * .25),
                height: (height * .2),
              ),
            ),
            Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Text(
                      '이메일 회원가입',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: TextFormField(
                      controller: id,
                      decoration: InputDecoration(
                        labelText: '이메일 주소',
                        hintText: '이메일 주소',
                        labelStyle: TextStyle(fontSize: 13),
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: pw1,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        hintText: '비밀번호',
                        labelStyle: TextStyle(fontSize: 13),
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(_showPW1 ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPW1 = !_showPW1;
                            });
                          },
                        ),
                      ),
                      obscureText: _showPW1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: pw2,
                      decoration: InputDecoration(
                        labelText: '비밀번호 확인',
                        hintText: '비밀번호 확인',
                        labelStyle: TextStyle(fontSize: 13),
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(_showPW2 ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPW2 = !_showPW2;
                            });
                          },
                        ),
                      ),
                      obscureText: _showPW2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
              child: Container(
                height: height * .05,
                width: width * .8,
                child: ElevatedButton(
                  onPressed: () {
                    auth.signUp(id.text.toString(), pw2.text.toString());
                    // showDialog 창
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 25,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10,),
                              Text('완료'),
                            ],
                          ),
                          content: Text('회원가입이 정상적으로 처리되었습니다. \n가입하신 이메일에 접속하여 이메일 인증을 받아주시길 바랍니다.'),
                          actions: [
                            TextButton(
                              child: Text('확인'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text('회원가입'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
