import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'search.dart';
import 'info.dart';
import 'dart:convert';
import 'homepage.dart';

int i = 0;
String uri = "";

class Board extends StatelessWidget {
  final String title;
  final String region;

  Board({required this.title, required this.region});

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
              '맞춤검색',
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Image.asset('assets/images/back.png'),
          ),
          backgroundColor: Colors.white,
        ),
        body: ItemList(
          title: title,
          region: region,
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
  final String region;
  final String title;
  final String pay;

  Item({
    required this.region,
    required this.title,
    required this.pay,
  });
}

List<Item> itemList = [];

class ItemList extends StatefulWidget {
  final String region;
  final String title;

  ItemList({required this.region, required this.title});

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

    String url = 'http://3.34.181.242:8081/boards';
    String appendedString = "";
    appendedString +=
    (widget.region == "") ? "/keyword?keyword=" + widget.title : "";
    appendedString +=
    (widget.title == "") ? "/region?region=" + widget.region : "";
    uri = url + appendedString;
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
      json.decode(utf8.decode(response.bodyBytes));
      for (var item in jsonData) {
        Item i = Item(
          region: item['region'].toString(),
          title: item['title'].toString(),
          pay: item['pay'].toString(),
        );
        fetchedItems.add(i);
        print(response.body);
        print(utf8.decode(response.bodyBytes));
      }
    }

    setState(() {
      itemList = fetchedItems;
    });
  }
   List <String> urlList = ['assets/images/riceField.jpeg', 'assets/images/farmField.jpg'];
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
        //final temp=ItemCard(itemList, index, i, urlList[index % 2]);
        return ItemCard(itemList, index, i, urlList[index % 2]);
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
  final String imgUrl;

  ItemCard(this.itemList, this.index, this.i, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Info(
                            prevUri: uri,
                          )));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imgUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                itemList[i].region,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                itemList[i].title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                itemList[i].pay,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}