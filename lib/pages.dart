import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<Issue> _issues = <Issue>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  //API叩いてるメソッド
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
    );
  }
}


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("名前:　深瀬　貴将（フカセ　タカマサ）"),
          Text("ディビジョン：アプリ＿iOS"),
          Text("自己紹介：ふかせでーす"),
        ],
      ),
    );
  }
}