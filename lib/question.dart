import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:external_path/external_path.dart';

class QuestionPage extends StatefulWidget {
  final int num; // 実験協力者番号
  final int age; // 年齢
  final String cnd; // 照明条件
  QuestionPage(this.num, this.age, this.cnd);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  double value1 = 0;
  double value2 = 0;

  late int _num;
  late int _age;
  late String _cnd;

  @override
  void initState() {
    super.initState();
    receiveNum(widget.num);
    receiveAge(widget.age);
    receiveCnd(widget.cnd);
  }

  void receiveNum(int num) {
    _num = num;
  }

  void receiveAge(int age) {
    _age = age;
  }

  void receiveCnd(String cnd) {
    _cnd = cnd;
  }

  void outputText(double value1, double value2) {
    getPubDirFile().then((File file) {
      file.writeAsString('実験協力者No.,年齢,条件,見やすさ,自然さ', encoding: utf8);
      file.writeAsString(_num.toString() +
          ',' +
          _age.toString() +
          ',' +
          _cnd.toString() +
          ',' +
          value1.toString() +
          ',' +
          value2.toString());
    });
  }

  Future<String> getPublicDirectoryPath() async {
    String path;
    path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print(path); // /storage/emulated/0/Download
    return path;
  }

  Future<File> getPubDirFile() async {
    final directory = await getPublicDirectoryPath();
    return File(directory + '/' + _cnd + '_person' + _num.toString() + '.csv');
  }

  //テキストファイルを保存するパスを取得する
  // Future<File> getFilePath() async {
  //   //Future<T> 関数名 asyncで<T>クラスを扱いとする非同期処理をする関数。非同期処理は、実行されると、その終了を待たずに他の処理が実行されます。関数内に１つでも非同期処理が実行される場合は非同期関数となります。
  //   final directory = await getTemporaryDirectory(); //await はその処理が終わるまで待つということ
  //   debugPrint(directory.path);
  //   return File(directory.path + '/person' + _num.toString() + '.txt');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アンケート'),
      ),
      body: Center(
        child: Form(
          child: ListView(
            children: [
              Text(_num.toString()),
              Text(_cnd),
              Text('見づらい ー 見やすい'),
              Slider(
                  min: -1,
                  max: 1,
                  value: value1,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.blueAccent,
                  onChanged: (a) {
                    setState(() {
                      value1 = a;
                    });
                  }),
              Text('（枠線が）不自然 ー 自然'),
              Slider(
                  min: -1,
                  max: 1,
                  value: value2,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.blueAccent,
                  onChanged: (a) {
                    setState(() {
                      value2 = a;
                    });
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          outputText(value1, value2);
        },
        tooltip: 'Next',
        child: Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }
}
