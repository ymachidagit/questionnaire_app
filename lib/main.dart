// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:questionnaire_app/question.dart';

void main() {
  runApp(const MyApp());
}

const List<String> cndList = <String>['なし', 'ネガポジ', '補色']; // 実験条件のリスト

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'アンケート'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int num = 0; // 実験協力者番号
  int age = 0; // 年齢
  String isSelectedCnd = cndList.first; // 選択されている照明条件

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment(-1.0, 1.0),
        color: Colors.blue[100],
        padding: EdgeInsets.all(50),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                      labelText: '実験協力者No.', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    num = int.parse(value);
                  }),
              SizedBox(height: 16),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: '年齢', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    age = int.parse(value);
                  }),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: '実験条件',
                ),
                items: cndList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: isSelectedCnd,
                onChanged: (String? value) {
                  setState(() {
                    isSelectedCnd = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionPage(num, age, isSelectedCnd)),
          );
        },
        tooltip: 'Next',
        child: Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }
}
