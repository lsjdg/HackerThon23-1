import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController registrationNumberController =
  TextEditingController();
  final TextEditingController issueDateController = TextEditingController();

  bool isKorean = true; // 내국인 선택 상태
  bool isForeigner = false; // 외국인 선택 상태

  Future<void> _register(BuildContext context) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final bool isLocal = isKorean;
    final bool isApproved = isKorean;
    final String registrationNumber =
    isForeigner ? registrationNumberController.text : "";
    final String issueDate = isForeigner ? issueDateController.text : "";

    final Map<String, dynamic> requestData = {
      'name': name,
      'local': isLocal,
      'approve': isApproved,
      'registrationNumber': registrationNumber,
      'issueDate': issueDate,
      'email': email,
      'password': password,
    };

    String url = 'http://3.34.181.242:8081/';
    final uri = Uri.parse(url + 'members/new');
    print(uri);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}"); // 추가: 입력된 데이터 출력

    if (!mounted) return;

    if (response.statusCode == 200) {
      // 가입 성공 시 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("가입 완료"),
            content: Text("회원 가입이 완료되었습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 알림 대화상자 닫기
                  Navigator.pop(context); // 회원가입 화면 닫기
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    } else {
      // 가입 실패 시 메시지 출력 등 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("가입 실패"),
            content: Text("서버와의 통신에 문제가 발생했습니다."),
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
        padding: EdgeInsets.all(16),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 156,
                ),
                Text(
                  "회원정보를 입력해 주세요.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "이름",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "홍길동", // 예시 이름
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "국적",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isKorean,
                      onChanged: (value) {
                        setState(() {
                          isKorean = value!;
                          isForeigner = !value;
                        });
                      },
                    ),
                    Text("내국인"),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isForeigner,
                      onChanged: (value) {
                        setState(() {
                          isForeigner = value!;
                          isKorean = !value;
                        });
                      },
                    ),
                    Text("외국인"),
                  ],
                ),
                if (isForeigner) ...[
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "외국인 등록번호",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    controller: registrationNumberController,
                    decoration: InputDecoration(
                      hintText: "000000-0000000",
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "발급일자",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    controller: issueDateController,
                    decoration: InputDecoration(
                      hintText: "발급일자 입력",
                    ),
                  ),
                ],
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
                    _register(context); // 가입 버튼 클릭 시 가입 함수 호출
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color.fromRGBO(122, 214, 191, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 60),
                  ),
                  child: Text(
                    "가입 하기",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}