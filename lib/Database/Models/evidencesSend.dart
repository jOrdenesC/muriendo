class EvidencesSend {
  final int number;
  final String idEvidence;
  final String phase;
  final Map classObject;
  final bool finished;
  final String kilocalories;
  final List questionnaire;

  EvidencesSend(
      {this.number,
      this.idEvidence,
      this.phase,
      this.classObject,
      this.finished,
      this.kilocalories,
      this.questionnaire});

  Map<String, dynamic> toMap() {
    return {
      'number': this.number,
      'idEvidence': this.idEvidence,
      'phase': this.phase,
      'classObject': this.classObject,
      'finished': this.finished,
      'kilocalories': this.kilocalories,
      'questionnaire': this.questionnaire
    };
  }

  factory EvidencesSend.fromMap(Map<String, dynamic> map) {
    return EvidencesSend(
        number: map["number"],
        idEvidence: map['idEvidence'],
        phase: map['phase'],
        classObject: map['classObject'],
        finished: map['finished'],
        kilocalories: map['kilocalories'],
        questionnaire: map['questionnaire']);
  }
}
