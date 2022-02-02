import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voting_app/answerModel.dart';
import 'package:voting_app/fireStore.dart';
import 'package:voting_app/questionModel.dart';

class PollCreatePage extends StatefulWidget {
  const PollCreatePage({Key? key}) : super(key: key);

  @override
  _PollCreatePageState createState() => _PollCreatePageState();
}

class _PollCreatePageState extends State<PollCreatePage> {
  List<AnswerModel> answerList = [];
  StreamController streamController = StreamController();
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirestoreManager.instance.table = "main";
          QuestionModel questionModel = QuestionModel(
              question: _textController.text,
              answers: answerList,
              userList: []);
          await FirestoreManager.instance
              .add(questionModel.question, questionModel.toMap());
          Navigator.pop(context);
        },
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Poll Create"),
      backgroundColor: Colors.grey,
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customTextField(
              hintText: "Question", minLine: 2, controller: _textController),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customTextField(hintText: "Number of answers"),
        ),
        StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapshot) => Column(
            children: answerList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: answerBox(e),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  Widget answerBox(final AnswerModel answer) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: TextField(
              onChanged: (value) {
                answer.text = value;
              },
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget customTextField(
      {required final String hintText,
      final int minLine = 1,
      final TextEditingController? controller}) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: minLine == 1
              ? const EdgeInsets.symmetric(horizontal: 8)
              : const EdgeInsets.all(8),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              try {
                answerList = [];
                for (int i = 0; i < int.parse(value); i++) {
                  answerList.add(AnswerModel());
                }
                streamController.add(true);
              } catch (e) {
                answerList = [];
                streamController.add(true);
              }
            },
            minLines: minLine,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
