class AnswerModel {
  String? text;
  int counter;
  AnswerModel({this.text, this.counter = 0});

  @override
  String toString() {
    return text ?? "null";
  }

  factory AnswerModel.fromMap(m) {
    return AnswerModel(
      text: m["text"],
      counter: m["counter"],
    );
  }

  toMap() {
    return {"text": this.text, "counter": this.counter};
  }

  vote() {
    counter++;
  }
}
