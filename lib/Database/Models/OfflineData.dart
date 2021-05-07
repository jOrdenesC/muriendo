class OfflineData {
  final String uuid;
  final double totalKilocalories;
  final String uriVideo;
  final List questionary;
  final String idClass;
  final List exercises;
  final String phase;
  final String course;
  final String type;
  final String uuidUser;

  OfflineData({
    this.uuid,
    this.uriVideo,
    this.questionary,
    this.idClass,
    this.course,
    this.phase,
    this.exercises,
    this.totalKilocalories,
    this.type,
    this.uuidUser
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'totalKilocalories': this.totalKilocalories,
      'course': this.course,
      'exercises': this.exercises,
      'uriVideo': this.uriVideo,
      'questionary': this.questionary,
      'idClass': this.idClass,
      'phase': this.phase,
      "type":this.type,
      "uuidUser": this.uuidUser
    };
  }

  factory OfflineData.fromMap(Map<String, dynamic> map) {
    return OfflineData(
        uuid: map['uuid'],
        totalKilocalories: map['totalKilocalories'],
        course: map['course'],
        exercises: map['exercises'],
        uriVideo: map['uriVideo'],
        questionary: map['questionary'],
        idClass: map['idClass'],
        phase: map['phase'],
        type: map['type'],
        uuidUser: map["uuidUser"]
        );
  }
}
