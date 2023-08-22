import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> sendData() async {
    final uri = Uri.parse('http://13.125.135.88:8081/admin/members/approve/2');
    final response = await http.post(
     uri,
      body: {'key': 'value'}, // 실제 데이터 추가
    );

    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      print('서버로부터의 응답: ${response.body}');
    } else {
      // 요청이 실패한 경우
      print('요청 실패 - 상태 코드: ${response.statusCode}');
    }
  }


  Future<void> fetchData() async {
    //final ipAddress = '13.125.135.88';
    //final port = 8081;
    //final url = Uri.http(ipAddress, '$port/members');
    //13.125.135.88:8081/members [get]
    final response = await http.get(Uri.parse('http://13.125.135.88:8081/boards'));
    if (response.statusCode == 200) {
      print('성공');
      String jsonData = response.body;
      // JSON 데이터를 파싱하여 Map으로 변환
      Map<String, dynamic> data = json.decode(jsonData);
      var value = data['key']; // 실제 키에 맞는 값을 가져오도록 수정
      print(value);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  sendData();
                },
                child: Text('데이터 전송'),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  fetchData(); // 함수 호출에 괄호 추가
                },
                child: Text('데이터 받기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
