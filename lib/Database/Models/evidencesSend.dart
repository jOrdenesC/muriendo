class EvidencesSend {
  final int number;
  final String idEvidence;
  final String phase;
  final Map classObject;
  final bool finished;
  final String kilocalories;

  EvidencesSend(
      {this.number,
      this.idEvidence,
      this.phase,
      this.classObject,
      this.finished,
      this.kilocalories});

  Map<String, dynamic> toMap() {
    return {
      'number': this.number,
      'idEvidence': this.idEvidence,
      'phase': this.phase,
      'classObject': this.classObject,
      'finished': this.finished,
      'kilocalories': this.kilocalories
    };
  }

  factory EvidencesSend.fromMap(Map<String, dynamic> map) {
    return EvidencesSend(
        number: map["number"],
        idEvidence: map['idEvidence'],
        phase: map['phase'],
        classObject: map['classObject'],
        finished: map['finished'],
        kilocalories: map['kilocalories']);
  }
}
