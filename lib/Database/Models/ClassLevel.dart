class ClassLevel {
  final int id;
  //Name of Gif document
  final List<dynamic> tips;
  //MicroPause
  final List<dynamic> pauses;
  //MacroPause
  final List<dynamic> macropause;
  //Excercises
  final List<dynamic> excerciseCalentamiento;
  final List<dynamic> excerciseFlexibilidad;
  final List<dynamic> excerciseDesarrollo;
  final List<dynamic> excerciseVueltaCalma;
  //name Excercise
  final int level;
  //Times
  final int timeCalentamiento;
  final int timeFlexibilidad;
  final int timeDesarrollo;
  final int timeVcalma;
  //Recomendattion
  final String classID;
  final int number;
  final List questionnaire;
  final bool isCustom;
  ClassLevel(
      {this.id,
      this.tips,
      this.pauses,
      this.macropause,
      this.excerciseCalentamiento,
      this.excerciseFlexibilidad,
      this.excerciseDesarrollo,
      this.excerciseVueltaCalma,
      this.level,
      this.timeCalentamiento,
      this.timeFlexibilidad,
      this.timeDesarrollo,
      this.timeVcalma,
      this.classID,
      this.number,
      this.questionnaire,
      this.isCustom
      });
  Map<String, dynamic> toMap() {
    return {
      'tips': this.tips,
      'pauses': this.pauses,
      'macropause': this.macropause,
      'excerciseCalentamiento': this.excerciseCalentamiento,
      'excerciseFlexibilidad': this.excerciseFlexibilidad,
      'excerciseDesarrollo': this.excerciseDesarrollo,
      'excerciseVueltaCalma': this.excerciseVueltaCalma,
      'level': this.level,
      'timeCalentamiento': this.timeCalentamiento,
      'timeFlexibilidad': this.timeFlexibilidad,
      'timeDesarrollo': this.timeDesarrollo,
      'timeVcalma': this.timeVcalma,
      'classID': this.classID,
      'number': this.number,
      'questionnaire': this.questionnaire,
      'isCustom': this.isCustom
    };
  }

  factory ClassLevel.fromMap(int id, Map<String, dynamic> map) {
    return ClassLevel(
        id: id,
        tips: map['tips'],
        pauses: map['pauses'],
        macropause: map['macropause'],
        excerciseCalentamiento: map['excerciseCalentamiento'],
        excerciseFlexibilidad: map['excerciseFlexibilidad'],
        excerciseDesarrollo: map['excerciseDesarrollo'],
        excerciseVueltaCalma: map['excerciseVueltaCalma'],
        level: map['level'],
        timeCalentamiento: map['timeCalentamiento'],
        timeFlexibilidad: map['timeFlexibilidad'],
        timeDesarrollo: map['timeDesarrollo'],
        timeVcalma: map['timeVcalma'],
        classID: map['classID'],
        number: map['number'],
        questionnaire: map['questionnaire'],
        isCustom: map["isCustom"]
        );
  }
}
