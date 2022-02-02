import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:voting_app/fireStore.dart';
import 'package:voting_app/questionModel.dart';
import 'package:voting_app/user.dart';

import 'answerModel.dart';

class PollPage extends StatefulWidget {
  QuestionModel question;
  PollPage({
    required this.question,
    Key? key,
  }) : super(key: key);

  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Poll Page"),
      backgroundColor: Colors.grey,
    );
  }

  Widget _body() {
    return ListView(
      children: [
        questionBox(widget.question),
        ...widget.question.answers.map((e) => answerBox(e)).toList(),
      ],
    );
  }

  Widget questionBox(QuestionModel question) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(question.question),
        ),
      ),
    );
  }

  Widget answerBox(AnswerModel answer) {
    return GestureDetector(
      onTap: () async {
        if (!widget.question.userList.contains(User.self!.userName)) {
          widget.question.userList.add(User.self!.userName);
          answer.vote();
          await FirestoreManager.instance.update(
            widget.question.question,
            widget.question.toMap(),
          );
          setState(() {});
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(answer.text! + "     " + answer.counter.toString()),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
