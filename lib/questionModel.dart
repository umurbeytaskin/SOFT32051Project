import 'package:voting_app/answerModel.dart';
import 'package:voting_app/userModel.dart';

class QuestionModel {
  String question;
  List answers;
  List userList;
  QuestionModel(
      {required this.question, required this.answers, required this.userList});

  factory QuestionModel.fromMap(m) {
    return QuestionModel(
        question: m["question"],
        answers: (m["answers"]
            .map((answer) => AnswerModel.fromMap(answer))
            .toList()),
        userList: m["userList"]);
  }

  toMap() {
    return {
      "question": this.question,
      "answers": this.answers.map((e) => e.toMap()).toList(),
      "userList": this.userList,
    };
  }
}
