class ExcerciseData {
  final int id;
  //ExcerciseID
  final int exerciseID;
  //Name of Video
  final String videoName;
  //ID of Audios
  final String excerciseNameAudioId; 

  final String recomendationAudioId;
  //KiloCalories Base Multiplier
  final num mets;
  //name Excercise
  final String nameExcercise;
  //Recomendattion
  final String recommendation;

  final List<dynamic> level;

  final List<dynamic> categories;

  final List<dynamic> stages;

  ExcerciseData(
      {this.id,
      this.exerciseID,
      this.videoName,
      this.excerciseNameAudioId,
      this.recomendationAudioId,
      this.mets,
      this.nameExcercise,
      this.recommendation,
      this.level,
      this.categories,
      this.stages});

  Map<String, dynamic> toMap() {
    return {
      'exerciseID': this.exerciseID,
      'videoName': this.videoName,
      'excerciseNameAudioId': this.excerciseNameAudioId,
      'recomendationAudioId': this.recomendationAudioId,
      'mets': mets,
      'nameExcercise': this.nameExcercise,
      'recommendation': this.recommendation,
      'level': this.level,
      'categories': this.categories,
      'stages': this.stages
    };
  }

  factory ExcerciseData.fromMap(int id, Map<String, dynamic> map) {
    return ExcerciseData(
        id: id,
        exerciseID: map['exerciseID'],
        videoName: map['name'],
        excerciseNameAudioId: map['excerciseNameAudioId'],
        recomendationAudioId: map['recomendationAudioId'],
        mets: map['mets'],
        nameExcercise: map['nameExcercise'],
        recommendation: map['recommendation'],
        level: map['level'],
        categories: map['categories'],
        stages: map['stages']);
  }

  ExcerciseData copyWith(
      {int id,
      String name,
      double gifduration,
      int maxFrames,
      bool hasAnim,
      int kiloCalories,
      String nameExcercise,
      String recommendation}) {
    return ExcerciseData(
        id: id ?? this.id,
        videoName: name ?? this.videoName,
        mets: kiloCalories ?? this.mets,
        nameExcercise: nameExcercise ?? this.nameExcercise,
        recommendation: recommendation ?? this.recommendation);
  }
}
