import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hackerton_pj/homepage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

void main() {
  runApp(AdminPage());
}

int i = 0;

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '관리자 승인',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Image.asset('assets/images/back.png'),
          ),
          backgroundColor: Colors.white,
        ),
        body: ItemList(),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage())); // 홈페이지로 이동하는 코드
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
      ),
    );
  }
}

class Item {
  final String name;
  final String registrationNumber;
  final String issueDate;
  final int memberId;

  Item({
    required this.name,
    required this.registrationNumber,
    required this.issueDate,
    required this.memberId,
  });
}

List<Item> itemList = [];

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  void initState() {
    super.initState();
    fetchItemData();
  }

  Future<void> fetchItemData() async {
    List<Item> fetchedItems = [];

    String url = 'http://3.34.181.242:8081/';

    final response = await http.get(Uri.parse(url + "admin/members"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print("debugggggg");
      print(jsonData);

      for (var item in jsonData) {
        Item i = Item(
          name: item['name'].toString(),
          registrationNumber: item['registrationNumber'].toString(),
          issueDate: item['issueDate'].toString(),
          memberId: item['memberId'],
        );
        fetchedItems.add(i);
      }
    }

    setState(() {
      itemList = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return itemList != null
        ? ListView.separated(
      itemCount: itemList.length,
      separatorBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          color: Color(0xFF7AD6BF),
          thickness: 1.0,
        ),
      ),
      itemBuilder: (context, index) {
        final currentItem = itemList[index];
        i = index;
        return ItemCard(itemList, index, i);
      },
    )
        : Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final List<Item> itemList;
  final int index;
  final int i;

  ItemCard(this.itemList, this.index, this.i);

  Future<void> _approveItem(int memberId) async {
    // 승인 처리를 위한 서버 요청
    String url = 'http://3.34.181.242:8081/';
    final response =
    await http.post(Uri.parse(url + 'admin/members/approve/$memberId'));

    // TODO: 서버 응답 처리
  }

  Future<void> _refuseItem(int memberId) async {
    // 거절 처리를 위한 서버 요청
    String url = 'http://3.34.181.242:8081/';
    final response =
    await http.post(Uri.parse(url + 'admin/members/refuse/$memberId'));

    // TODO: 서버 응답 처리
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  '이름\n------\n${itemList[i].name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 52,
                ),
                Text(
                  '외국인등록번호\n-------------------\n${itemList[i].registrationNumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 52,
                ),
                Text(
                  '발급일자\n-----------\n${itemList[i].issueDate}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // 승인 버튼
                ElevatedButton(
                  onPressed: () {
                    _approveItem(itemList[i].memberId); // 아이템 승인 처리
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('승인'),
                ),
                SizedBox(width: 10), // 버튼 사이 간격
                // 거절 버튼
                ElevatedButton(
                  onPressed: () {
                    _refuseItem(itemList[i].memberId); // 아이템 거절 처리
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('거절'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}