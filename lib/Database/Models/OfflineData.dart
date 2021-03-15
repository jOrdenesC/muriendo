class OfflineData {
  final int uuid;
  final double totalKilocalories;
  final String uriVideo;
  final List questionary;
  final String idClass;
  final List exercices;
  final String phase;
  final String course;

  OfflineData({
    this.uuid,
    this.uriVideo,
    this.questionary,
    this.idClass,
    this.course,
    this.phase,
    this.exercices,
    this.totalKilocalories,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'totalKilocalories': this.totalKilocalories,
      'course': this.course,
      'exercises': this.exercices,
      'uriVideo': this.uriVideo,
      'questionary': this.questionary,
      'idClass': this.idClass,
      'phase': this.phase
    };
  }

  factory OfflineData.fromMap(Map<String, dynamic> map) {
    return OfflineData(
        uuid: map['uuid'],
        totalKilocalories: map['totalKilocalories'],
        course: map['course'],
        exercices: map['exercices'],
        uriVideo: map['uriVideo'],
        questionary: map['questionary'],
        idClass: map['idClass'],
        phase: map['phase']);
  }
}
