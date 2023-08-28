import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  // 일터 등록 페이지
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isAccommodationProvided = false;
  bool _isMealProvided = false;
  int pay = 0;
  String _selectedValue = "인천";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _payController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  Future<void> _submitRegistration() async {
    final String title = _titleController.text;
    final String region = _regionController.text;
    final String location = _locationController.text;
    final String deadline = _deadlineController.text;
    final String term = _termController.text;
    final String day = _dayController.text;
    final String hour = _hourController.text;
    final String type = _typeController.text;
    final String number = _numberController.text;
    final bool isRoom = _isAccommodationProvided;
    final bool isMeal = _isMealProvided;

    final Map<String, dynamic> requestData = {
      'title': title,
      'region': region,
      'location': location,
      'deadline': deadline,
      'workTerm': term,
      'workDay': day,
      'workHour': hour,
      'pay': 1000,
      'type': type,
      'creatorNumber': number,
      'room': isRoom,
      'meal': isMeal
    };
    String url = 'http://3.34.181.242:8081/';
    final uri = Uri.parse(url + 'boards/new');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    if (!mounted) return;
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
    } else {
      print({response.statusCode});
      print("Response: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // 홈페이지로 이동하는 코드
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Image.asset("assets/images/back.png"),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "일터등록",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "근무처 정보",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "구직자가 근무하게 될 근무지 정보(주소,\n 공고제목, 로고, 일터 사진)를 입력해주세요.",
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 31, 30, 30),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "공고 제목",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "예) 사과 수확 함께 할 알바생을 찾아요.", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "근무지 주소",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  DropdownButton<String>(
                    underline: Container(),
                    hint: Text("예) 인천"),
                    items: [
                      DropdownMenuItem(
                        value: "인천",
                        child: Text("인천"),
                      ),
                      DropdownMenuItem(
                        value: "서울",
                        child: Text("서울"),
                      ),
                      DropdownMenuItem(
                        value: "경기",
                        child: Text("경기"),
                      ),
                      DropdownMenuItem(
                        value: "강원",
                        child: Text("강원"),
                      ),
                      DropdownMenuItem(
                        value: "충남",
                        child: Text("충남"),
                      ),
                      DropdownMenuItem(
                        value: "충북",
                        child: Text("충북"),
                      ),
                      DropdownMenuItem(
                        value: "세종",
                        child: Text("세종"),
                      ),
                      DropdownMenuItem(
                        value: "대전",
                        child: Text("대전"),
                      ),
                      DropdownMenuItem(
                        value: "전북",
                        child: Text("전북"),
                      ),
                      DropdownMenuItem(
                        value: "전남",
                        child: Text("전남"),
                      ),
                      DropdownMenuItem(
                        value: "광주",
                        child: Text("광주"),
                      ),
                      DropdownMenuItem(
                        value: "경북",
                        child: Text("경북"),
                      ),
                      DropdownMenuItem(
                        value: "경남",
                        child: Text("경남"),
                      ),
                      DropdownMenuItem(
                        value: "대구",
                        child: Text("대구"),
                      ),
                      DropdownMenuItem(
                        value: "부산",
                        child: Text("부산"),
                      ),
                      DropdownMenuItem(
                        value: "울산",
                        child: Text("울산"),
                      ),
                      DropdownMenuItem(
                        value: "제주",
                        child: Text("제주"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                        _regionController.text = value;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _regionController,
                      decoration: InputDecoration(
                        hintText: "예) 인천", // 예시 이름
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     // 버튼이 눌렸을 때 처리하는 코드를 추가할 수 있습니다.
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(
                  //           color: Color.fromRGBO(
                  //               122, 214, 191, 1.0)), // 겉 선 색상 설정
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Text(
                  //       "주소 찾기",
                  //       style: TextStyle(
                  //         color: Color.fromRGBO(122, 214, 191, 1.0),
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "상세 주소 입력", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "일의 종류",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(
                  hintText: "예) 사과 수확 및 가지치기.", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "모집 기간",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  hintText: "예) 8월 25일까지", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "근무 기간",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _termController,
                decoration: InputDecoration(
                  hintText: "예) 3개월", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "근무 요일 및 시간",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dayController,
                      decoration: InputDecoration(
                        hintText: "예) 월, 수, 금",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // 간격 조절
                  Expanded(
                    child: TextField(
                      controller: _hourController,
                      decoration: InputDecoration(
                        hintText: "예) 06:00~15:00",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(122, 214, 191, 1.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "급여",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _payController,
                decoration: InputDecoration(
                  hintText: "예) 일급 130,000", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "숙식 제공 여부",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text("숙박 제공 가능"),
                    value: _isAccommodationProvided,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isAccommodationProvided = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.grey,
                    // 체크된 경우의 색상
                    checkColor: Colors.white, // 체크 아이콘의 색상
                  ),
                  CheckboxListTile(
                    title: Text("식사 제공 가능"),
                    value: _isMealProvided,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isMealProvided = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.grey,
                    // 체크된 경우의 색상
                    checkColor: Colors.white, // 체크 아이콘의 색상
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "연락처",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: "예) 010-1234-5678", // 예시 이름
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(122, 214, 191, 1.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _submitRegistration(); // 게시글 등록 시도
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("알림"),
                        content: Text("게시글이 성공적으로 등록되었습니다."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // 다이얼로그 닫기
                              Navigator.pushNamed(context, '/home'); // 홈페이지로 이동
                            },
                            child: Text("확인"),
                          ),
                        ],
                      );
                    },
                  );
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
                  "등록하기",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color(0xFFD0F5EC),
          child: Container(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home'); // 홈페이지로 이동하는 코드
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Icon(Icons.home, color: Color(0xFF7AD6BF)),
                      Text(
                        "home",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(122, 214, 191, 1.0),
                        ),
                      ),
                    ],
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