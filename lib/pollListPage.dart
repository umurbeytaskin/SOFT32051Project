import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voting_app/answerModel.dart';
import 'package:voting_app/fireStore.dart';
import 'package:voting_app/pollPage.dart';
import 'package:voting_app/questionModel.dart';

class PollListPage extends StatefulWidget {
  const PollListPage({Key? key}) : super(key: key);

  @override
  _PollListPageState createState() => _PollListPageState();
}

class _PollListPageState extends State<PollListPage> {
  StreamController streamController = StreamController();
  List<QuestionModel> questionList = [];

  load() async {
    FirestoreManager.instance.table = "main";
    var response = await FirestoreManager.instance.getAll();
    print(FirestoreManager.instance.table);
    print(response);
    questionList = response
        .map(
          (e) => QuestionModel.fromMap(e),
        )
        .toList();
    streamController.add(true);
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Poll List"),
      backgroundColor: Colors.grey,
    );
  }

  Widget _body() {
    return StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView(
            children: questionList
                .map(
                  (e) => questionBox(e),
                )
                .toList(),
          );
        });
  }

  Widget questionBox(QuestionModel question) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PollPage(question: question),
          ),
        );
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(question.question),
          ),
        ),
      ),
    );
  }
}
