class TipsData {
  final int id;
  //Audio ID
  final num tipsID;
  //MicroPause
  final String tip;

  final String audioQuestion;

  final String audioTips;

  final String audioVF;

  final String documentID;
  TipsData(
      {this.id,
      this.tipsID,
      this.tip,
      this.audioQuestion,
      this.audioTips,
      this.audioVF,
      this.documentID});

  Map<String, dynamic> toMap() {
    return {
      'tipsID': this.tipsID,
      'tip': this.tip,
      'audioQuestion': this.audioQuestion,
      'audioTips': this.audioTips,
      'audioVF': this.audioVF,
      'documentID': this.documentID
    };
  }

  factory TipsData.fromMap(int id, Map<String, dynamic> map) {
    return TipsData(
        id: id,
        tipsID: map['tipsID'],
        tip: map['tip'],
        audioQuestion: map['audioQuestion'],
        audioTips: map['audioTips'],
        audioVF: map['audioVF'],
        documentID: map['documentID']);
  }
}
