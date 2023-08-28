import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'search.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'login.dart';
import 'signup.dart';
import 'recruit.dart';
import 'homepage.dart';
import 'board.dart';
import 'info.dart';
import 'dart:async';
import 'admin_approval.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'), // 한국어 로케일 추가
        // 다른 로케일도 필요하다면 여기에 추가
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // 앱 실행 시 처음 띄워줄 페이지 경로
      routes: {
        '/': (context) => FirstPage(), // 첫 번째 페이지인 OnboardingPage
        '/login': (context) => LoginPage(), // 로그인 페이지인 LoginPage
        '/home': (context) => HomePage(), // 홈 페이지인 HomePage
        '/search': (context) => SearchPage(),
        'admin': (context) => AdminPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  // 시작 화면 페이지
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1초 후에 온보딩 페이지로 이동하는 코드
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 1), // 애니메이션 지속 시간 설정
          pageBuilder: (_, __, ___) => OnboardingPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation, // 페이드 효과 적용
              child: child,
            );
          },
        ),
      );
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_firstPage.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Color.fromRGBO(208, 245, 236, 100),
        pages: [
          // 두 번째 페이지
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 185,
                ),
                Image.asset(
                  'assets/images/hand.png',
                  width: 177,
                  height: 177,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 30), // 이미지와 텍스트 사이의 간격 조절
                Text(
                  '일손이 부족하신가요?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            decoration: PageDecoration(
              bodyTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),

          // 세 번째 페이지
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 185,
                ),
                Image.asset(
                  'assets/images/car.png',
                  width: 177,
                  height: 177,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 30), // 이미지와 텍스트 사이의 간격 조절
                Text(
                  '농장 체험 및 일손돕기에\n관심이 있으신가요?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            decoration: PageDecoration(
              bodyTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          // 네 번째 페이지
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 185,
                ),
                Image.asset(
                  'assets/images/basket.png',
                  width: 177,
                  height: 177,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 30), // 이미지와 텍스트 사이의 간격 조절
                Text(
                  '농촌모여가\n도와드릴게요!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            decoration: PageDecoration(
              bodyTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
        showNextButton: true, // Next 버튼 표시
        showDoneButton: true, // Done 버튼 표시
        dotsDecorator: DotsDecorator(
          // 페이지 인덱스를 나타내는 점 설정
          size: Size(10, 10),
          color: Colors.white,
          activeSize: Size(20, 10),
          activeColor: Color.fromRGBO(122, 214, 191, 1.0),
        ),
        next: Container(
          width: 80, // 버튼 너비 조정
          height: 40, // 버튼 높이 조정
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white, // 버튼 배경색
            borderRadius: BorderRadius.circular(20), // 버튼 테두리 둥글기 조정
          ),
          child: Text(
            "다음",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(122, 214, 191, 1.0), // 텍스트 색상
              fontSize: 16, // 텍스트 크기
            ),
          ),
        ),
        done: Container(
          width: 100, // 버튼 너비 조정
          height: 40, // 버튼 높이 조정
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white, // 버튼 배경색
            borderRadius: BorderRadius.circular(20), // 버튼 테두리 둥글기 조정
          ),
          child: Text(
            "시작하기",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(122, 214, 191, 1.0), // 텍스트 색상
              fontSize: 16, // 텍스트 크기
            ),
          ),
        ),
        onDone: () {
          // Done 클릭시 LoginPage로 이동
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }
}

class UserProvider with ChangeNotifier {
  String userName = ''; // 초기값은 빈 문자열로 설정

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }
}