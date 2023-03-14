import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class QuestionnairePage extends StatelessWidget {
  QuestionnairePage(this.num, this.age);
  int num;
  int age;

  double value1 = 0;
  double value2 = 0;

  void outputText(double value1, double value2) {
    getFilePath().then((File file) {
      file.writeAsString(value1.toString() + ',' + value2.toString());
    });
  }

  //テキストファイルを保存するパスを取得する
  Future<File> getFilePath() async {
    //Future<T> 関数名 asyncで<T>クラスを扱いとする非同期処理をする関数。非同期処理は、実行されると、その終了を待たずに他の処理が実行されます。関数内に１つでも非同期処理が実行される場合は非同期関数となります。
    final directory = await getTemporaryDirectory(); //await はその処理が終わるまで待つということ
    debugPrint(directory.path);
    return File(directory.path + '/person' + num.toString() + '.txt');
  }

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
              Text(num.toString()),
              Text(age.toString()),
              Text('見づらい ー 見やすい'),
              Slider(
                  min: -1,
                  max: 1,
                  value: value1,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.blueAccent,
                  onChanged: (a) {
                    value1 = a;
                  }),
              Text('（枠線が）不自然 ー 自然'),
              Slider(
                  min: -1,
                  max: 1,
                  value: value1,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.blueAccent,
                  onChanged: (a) {
                    value2 = a;
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
