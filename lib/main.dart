
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutterTest1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ArsagaLibraryBooks'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class Issue {
  Issue({
    this.title,
    this.thumbnail,
  });

  final String title;
  final String thumbnail;
}


//    _をつけるとfilePrivate的な  extendsは継承のこと(上で作ったカスタムクラスを継承/overrideなどしてる）
class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _page = 0;

  List<Issue> _issues = <Issue>[];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    //API叩いてるメソッド
    _load();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }


  //-----------メソッドを定義--------------

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void onTapBottomNavigationBar(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300), //0.3秒
        curve: Curves.ease
    );
  }

  //-------------------------------------


  Future<void> _load() async {
    final res = await http.get('https://www.googleapis.com/books/v1/volumes?q=伊坂幸太郎');
    final data = json.decode(res.body);
    setState(() {
      final jsonRoot = data as Map;
      final issues = jsonRoot['items'] as List;
      issues.forEach((dynamic element) {
        final issue = element as Map;
        _issues.add(Issue(
          title: issue['volumeInfo']['title'] as String,
          thumbnail: issue['volumeInfo']['imageLinks']['smallThumbnail'] as String,
        ));
      });
    });
  }

  //ここでUIに関する諸々の設定ができる
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
        if (index >= _issues.length) {
          return null;
        }

        final issue = _issues[index];

        return ListTile(
          leading: Image.network(issue.thumbnail),
          title: Text(issue.title),
        );
      },
      ),

//      body: PageView(
//        controller: _pageController,
//        onPageChanged: onPageChanged,
//      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
//        onTap: onTapBottomNavigationBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text("Library")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Home")
          ),
        ],
      ),
    );
  }
}