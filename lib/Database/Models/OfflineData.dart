class OfflineData {
  final int uuid;
  final String cloudflareId;
  final double totalKilocalories;
  final String uriVideo;
  final List questionary;
  final String idClass;
  final String videoName;
  final List exercices;
  final bool uploaded;

  OfflineData(
      {this.uuid,
      this.uriVideo,
      this.questionary,
      this.idClass,
      this.videoName,
      this.cloudflareId,
      this.exercices,
      this.totalKilocalories,
      this.uploaded
      });

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'totalKilocalories': this.totalKilocalories,
      'cloudflareId': this.cloudflareId,
      'exercises': this.exercices,
      'uriVideo': this.uriVideo,
      'questionary': this.questionary,
      'idClass': this.idClass,
      'videoName': this.videoName,
      'uploaded': this.uploaded
    };
  }

  factory OfflineData.fromMap(Map<String, dynamic> map) {
    return OfflineData(
        uuid: map['uuid'],
        totalKilocalories: map['totalKilocalories'],
        cloudflareId: map['cloudflareId'],
        exercices: map['exercices'],
        uriVideo: map['uriVideo'],
        questionary: map['questionary'],
        idClass: map['idClass'],
        videoName: map['date'],
        uploaded: map['uploaded']
        );
  }
}
