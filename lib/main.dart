
import 'package:flutter/material.dart';
import 'pages.dart';

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

//    _をつけるとfilePrivate的な
//    extendsは継承のこと(上で作ったカスタムクラスを継承/overrideなどしてる）
class _MyHomePageState extends State<MyHomePage> {

  int _currentPageIndex = 0;

  var pages = [
    ListPage(),
    MyPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  //-----------メソッドを定義--------------


  //-------------------------------------

  //ここでUIに関する諸々の設定ができる
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: pages[_currentPageIndex],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
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