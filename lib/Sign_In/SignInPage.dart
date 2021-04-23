import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///D:/StudyFolder2/firebase_todo_app/lib/utils/CRUD.dart';
import 'package:firebase_todo_app/Home/HomePage.dart';
import 'package:firebase_todo_app/Sign_In/Auth/Auth.dart';
import 'package:firebase_todo_app/Sign_In/Auth/GoogleAuth.dart';
import 'package:firebase_todo_app/Sign_Up/SignUpPage.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // 이메일 로그인에 필요한 변수들 선언
  final key = GlobalKey<FormState>();
  var id = TextEditingController();
  var pw = TextEditingController();
  bool _showPW = true;
  bool isLogin = true;
  Auth auth = new Auth();
  String email = "";
  String password = "";
  String? errorText; // errorText = ""; 사용하게 되면 값이 생기기 때문에 TextFormField 에 에러표시 뜸

  // TextEditingController 를 사용후 리소스 반환을 위해 dispose()
  @override
  void dispose() {
    id.dispose();
    pw.dispose();
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
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Text(
                      '이메일 로그인',
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
                        labelStyle: TextStyle(fontSize: 15),
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        errorText: errorText,
                      ),
                      validator: (val) =>
                          !EmailValidator.validate(val!, true) ? '이메일 형식이 아닙니다' : null,
                      onSaved: (val) => email = val!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                        controller: pw,
                        decoration: InputDecoration(
                            labelText: '비밀번호',
                            hintText: '비밀번호',
                            labelStyle: TextStyle(fontSize: 15),
                            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(_showPW ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _showPW = !_showPW;
                                });
                              },
                            )),
                        obscureText: _showPW,
                        validator: (value) {
                          if (value == null) {
                            return '비밀번호를 입력하세요';
                          } else if (value.isEmpty) return '비밀번호를 입력하세요';
                        }),
                  ),
                ],
              ),
            ),
            isLogin
                ? Container()
                : Container(
                    child: Text(
                      "이메일 또는 비밀번호가 올바르지 않습니다. \n다시 시도해주세요.",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
              child: Container(
                height: height * .05,
                width: width * .8,
                child: ElevatedButton(
                  onPressed: () async {
                    // 각 form 의 validator 를 실행
                    // 질문 : if 문을 여러개 겹치는 방법말고 삼항연산자 를 사용하는게 맞습니까?
                    if (key.currentState!.validate()) {
                      final result = await auth.signIn(id.text.toString(), pw.text.toString());
                      if (result) {
                        if (auth.firebaseAuth.currentUser!.emailVerified) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.check, size: 25, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text('완료')
                                  ],
                                ),
                                content: Text('로그인 성공'),
                                actions: [
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () async {
                                      // 유저의 정보를 fireStore 저장
                                      // 1. 로그인을 할때마다 새로운 유저의 정보를 덮어씌울수가 있음
                                      // 2. 유저의 정보가 바뀌지 않는 정보면 새로 갱신할 필요가 없기 때문에 id,pw,emailVerified 만 확인하면 될까요?
                                      // 2-1 . 어떤 서비스인지에 따라 매번 덮어씌우는게 맞는지 , 바뀌는정보만 갱신하는게 맞는지?
                                      await createUserDoc(auth.firebaseAuth.currentUser);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  HomePage(user: auth.firebaseAuth.currentUser)),
                                          (route) => false);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.announcement_outlined,
                                        size: 25, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text('이메일 인증필요'),
                                  ],
                                ),
                                content: Text('회원가입하실때 사용하신 이메일에 메일에 들어가셔서 본인인증을 진행해주시길 바랍니다.'),
                                actions: [
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                        setState(() {
                          isLogin = true;
                        });
                      } else {
                        setState(() {
                          isLogin = false;
                        });
                      }
                    }
                  },
                  child: Text('로그인'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Todo App 은 처음이신가요?'),
                TextButton(
                  child: Text(
                    '회원가입',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    '비밀번호를 잊어버리셨나요?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
              ],
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                User? user = await Authentication.signInWithGoogle(context: context);
                await createUserDoc(user);
                // (route) => false; -
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => HomePage(user: user)), (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/google_logo.png"),
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Google 로그인',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
