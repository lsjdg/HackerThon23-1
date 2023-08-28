import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    String url = 'http://3.34.181.242:8081/';
    final uri = Uri.parse(url + 'members/login');
    print(uri);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      if (email == "admin1234" && password == "shdchsahdu") {
        Navigator.pushReplacementNamed(context, 'admin');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      // 로그인 실패 시 메시지 출력 등 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("로그인 실패"),
            content: Text("잘못된 이메일 주소 또는 비밀번호입니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                ),
                Text(
                  "안녕하세요!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("로그인 정보를 입력해 주세요.",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 10,
                ),
                Image.asset("assets/images/login.png"),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "이메일 주소",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "abc1234@naver.com", // 예시 이메일
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "비밀번호",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "비밀번호를 입력하세요.",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 로그인 버튼을 눌렀을 때 HomePage로 이동
                    _login(context); // 로그인 버튼 클릭 시 로그인 함수 호출
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16), // 버튼 내용과 테두리 간격 조절
                    backgroundColor: Color.fromRGBO(122, 214, 191, 1.0), // 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 꼭짓점 둥글게 설정
                    ),
                    minimumSize: Size(double.infinity, 60), // 가로 크기를 늘림
                  ),
                  child: Text(
                    "로그인하기",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "아직 회원이 아니신가요?",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}