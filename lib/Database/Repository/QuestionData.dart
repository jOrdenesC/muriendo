class QuestionData {
  final int id;
  //Audio ID
  final int tipID;
  //MicroPause
  final String questionVf;

  final String correctVf;

  final String questionAl;

  final String correctAl;

  final List<String> alternatives;

  QuestionData(
      {this.id,
      this.tipID,
      this.questionVf,
      this.correctVf,
      this.questionAl,
      this.correctAl,
      this.alternatives});

  Map<String, dynamic> toMap() {
    return {
      'tipID': this.tipID,
      'questionVf': this.questionVf,
      'correctVf': this.correctVf,
      'questionAl': this.questionAl,
      'correctAl': this.correctAl,
      'alternatives': this.alternatives
    };
  }

  factory QuestionData.fromMap(int id, Map<String, dynamic> map) {
    return QuestionData(
        id: id,
        tipID: map['tipID'],
        questionVf: map['questionVf'],
        correctVf: map['correctVf'],
        questionAl: map['questionAl'],
        correctAl: map['correctAl'],
        alternatives: map['alternatives']);
  }
}
