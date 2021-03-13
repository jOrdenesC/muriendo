class QuestionaryData {
  final String uuid;
  final List questionary;


  QuestionaryData(
      {this.uuid,
      this.questionary
});

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'questionary': this.questionary
    };
  }

  factory QuestionaryData.fromMap(Map<String, dynamic> map) {
    return QuestionaryData(
        uuid: map['uuid'],
        questionary: map['questionary']
        );
  }
}
