import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:hackerton_pj/admin_approval.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'register.dart';
import 'search.dart';
import 'recruit.dart';
import 'info.dart';
import 'board.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String userName = ''; // 회원 이름을 저장할 변수
  final List<Widget> _pages = [
    HomePage(),
    RegistrationPage(),
    SearchPage(),
    RecruitmentPage(),
  ]; // 이곳에 각 화면 위젯을 추가
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
  List<DateTime> selectedDays = []; // 선택한 날짜를 저장하는 리스트
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "안녕하세요 사용자님\n일자리를 찾아보세요!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 35,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                height: 2.0,
                color: Color.fromRGBO(122, 214, 191, 1.0),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // "일터등록" 버튼이 눌렸을 때 다른 페이지로 이동하는 코드
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistrationPage()), // 다른 페이지의 위젯
                          );
                        },
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            'assets/images/homepage_3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "일터등록",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // "맞춤검색" 버튼이 눌렸을 때 다른 페이지로 이동하는 코드
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage()), // 다른 페이지의 위젯
                          );
                        },
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            'assets/images/homepage_2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "맞춤검색",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // "동료모집" 버튼이 눌렸을 때 다른 페이지로 이동하는 코드
                        },
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            'assets/images/homepage_1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "동료모집",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 2.0,
                color: Color.fromRGBO(122, 214, 191, 1.0),
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: 372,
                  height: 225, // 높이를 늘림
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "이름",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "나이",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "소속",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "돕기 이력",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: Color.fromRGBO(122, 214, 191, 1.0),
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "인하소",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "23",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "인하대학교",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "인천광역시 미추홀구 사과농장...\n단양군 가곡면 사평2리 마늘뽑기...",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/images/cow.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 2.0,
                color: Color.fromRGBO(122, 214, 191, 1.0),
              ),
              TableCalendar(
                // 캘린더 위젯
                headerVisible: true,
                locale: 'ko_KR',
                firstDay: DateTime.utc(2021, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                selectedDayPredicate: (DateTime day) {
                  return selectedDays.contains(day);
                },
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  setState(() {
                    if (selectedDays.contains(selectedDay)) {
                      selectedDays.remove(selectedDay);
                    } else {
                      selectedDays.add(selectedDay);
                    }
                    this.focusedDay = focusedDay;
                  });
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                      color: Color.fromRGBO(122, 214, 191, 1.0), fontSize: 25),
                  titleTextFormatter: (DateTime focusedDay, dynamic locale) {
                    return '${DateFormat.yMMMM().format(focusedDay)}';
                  },
                ),
                calendarStyle: CalendarStyle(
                  // 캘린더 날짜 부분 스타일
                  selectedDecoration: BoxDecoration(
                    color: Color.fromRGBO(122, 214, 191, 1.0),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    // 오늘 날짜에 미선택 시 파란색 칠해져있어서 흰색으로 바꿈
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.black),
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
            height: 70.0, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}