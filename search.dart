import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'signup.dart';
import 'board.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  String _selectedValue = "인천";

  Future<void> _sendTitle(BuildContext context) async {
    final String title = _titleController.text;

    final Map<String, dynamic> requestData = {
      'title': title,
    };

    String url = 'http://3.34.181.242:8081/';
    final uri = Uri.parse(url + 'boards/keyword?keyword=' + title);
    print(uri);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
      //body: jsonEncode(requestData),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      print("response : ${response.body}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Board(title: title, region: "")));
    } else {
      // 로그인 실패 시 메시지 출력 등 처리
      print("response : ${response.body}");
    }
  }

  Future<void> _sendRegion(BuildContext context) async {
    final String region = _regionController.text;

    final Map<String, dynamic> requestData = {
      'region': region,
    };

    String url = 'http://3.34.181.242:8081/';
    final uri = Uri.parse(url + 'boards/keyword?keyword=' + region);
    print(uri);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
      //body: jsonEncode(requestData),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      print("response : ${response.body}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Board(title: "", region: region)));
    } else {
      // 로그인 실패 시 메시지 출력 등 처리
      print("response : ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      "맞춤검색",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("검색 정보를 입력해 주세요.",
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "제목",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // 조절 가능한 간격
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "사과 농사", // 예시 이메일
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // 조절 가능한 간격
                        ElevatedButton(
                          onPressed: () {
                            // 검색 버튼을 눌렀을 때 처리
                            _sendTitle(context); // 검색 버튼 클릭 시 함수 호출
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            backgroundColor: Color.fromRGBO(122, 214, 191, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // 버튼의 크기 조절을 더욱 정교하게 하려면 아래의 값을 조정하세요.
                            minimumSize: Size(120, 60), // 가로 크기 조절
                          ),
                          child: Text(
                            "검색",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "지역",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // 조절 가능한 간격
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _regionController,
                            decoration: InputDecoration(
                              hintText: "인천", // 예시 이메일
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
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
                        SizedBox(width: 10), // 조절 가능한 간격
                        ElevatedButton(
                          onPressed: () {
                            // 검색 버튼을 눌렀을 때 처리
                            _sendRegion(context); // 검색 버튼 클릭 시 함수 호출
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            backgroundColor: Color.fromRGBO(122, 214, 191, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // 버튼의 크기 조절을 더욱 정교하게 하려면 아래의 값을 조정하세요.
                            minimumSize: Size(120, 60), // 가로 크기 조절
                          ),
                          child: Text(
                            "검색",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 150, // Set the desired width
                  height: 300, // Set the desired height
                  child: Image.asset('assets/images/map.png'),
                )
              ],
            ),
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