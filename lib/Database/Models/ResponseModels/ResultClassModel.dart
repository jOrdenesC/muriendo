class ResultModel {
  Times times;
  List<Exercises> exercisesCalentamiento;
  List<Exercises> exercisesFlexibilidad;
  List<Exercises> exercisesDesarrollo;
  List<Exercises> exercisesVueltaCalma;
  List<Tips> tips;
  String sId;
  num number;
  num level;
  List<Pauses> pauses;
  List<Questionnaire> questionnaire;

  ResultModel(
      {this.times,
      this.exercisesCalentamiento,
      this.exercisesFlexibilidad,
      this.exercisesDesarrollo,
      this.exercisesVueltaCalma,
      this.tips,
      this.sId,
      this.number,
      this.level,
      this.pauses,
      this.questionnaire});

  ResultModel.fromJson(Map<String, dynamic> json) {
    times = json['times'] != null ? new Times.fromJson(json['times']) : null;
    if (json['exercisesCalentamiento'] != null) {
      exercisesCalentamiento = new List<Exercises>();
      json['exercisesCalentamiento'].forEach((v) {
        exercisesCalentamiento.add(new Exercises.fromJson(v));
      });
    }
    if (json['exercisesFlexibilidad'] != null) {
      exercisesFlexibilidad = new List<Exercises>();
      json['exercisesFlexibilidad'].forEach((v) {
        exercisesFlexibilidad.add(new Exercises.fromJson(v));
      });
    }
    if (json['exercisesDesarrollo'] != null) {
      exercisesDesarrollo = new List<Exercises>();
      json['exercisesDesarrollo'].forEach((v) {
        exercisesDesarrollo.add(new Exercises.fromJson(v));
      });
    }
    if (json['exercisesVueltaCalma'] != null) {
      exercisesVueltaCalma = new List<Exercises>();
      json['exercisesVueltaCalma'].forEach((v) {
        exercisesVueltaCalma.add(new Exercises.fromJson(v));
      });
    }
    if (json['tips'] != null) {
      tips = new List<Tips>();
      json['tips'].forEach((v) {
        tips.add(new Tips.fromJson(v));
      });
    }
    sId = json['_id'];
    number = json['number'];
    level = json['level'];
    if (json['pauses'] != null) {
      pauses = new List<Pauses>();
      json['pauses'].forEach((v) {
        pauses.add(new Pauses.fromJson(v));
      });
    }
    if (json['questionnaire'] != null) {
      questionnaire = new List<Questionnaire>();
      json['questionnaire'].forEach((v) {
        questionnaire.add(new Questionnaire.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.times != null) {
      data['times'] = this.times.toJson();
    }
    if (this.exercisesCalentamiento != null) {
      data['exercisesCalentamiento'] =
          this.exercisesCalentamiento.map((v) => v.toJson()).toList();
    }
    if (this.exercisesFlexibilidad != null) {
      data['exercisesFlexibilidad'] =
          this.exercisesFlexibilidad.map((v) => v.toJson()).toList();
    }
    if (this.exercisesDesarrollo != null) {
      data['exercisesDesarrollo'] =
          this.exercisesDesarrollo.map((v) => v.toJson()).toList();
    }
    if (this.exercisesVueltaCalma != null) {
      data['exercisesVueltaCalma'] =
          this.exercisesVueltaCalma.map((v) => v.toJson()).toList();
    }
    if (this.tips != null) {
      data['tips'] = this.tips.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['number'] = this.number;
    data['level'] = this.level;
    if (this.pauses != null) {
      data['pauses'] = this.pauses.map((v) => v.toJson()).toList();
    }
    if (this.questionnaire != null) {
      data['questionnaire'] =
          this.questionnaire.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  int calentamiento;
  int desarrollo;
  int vcalma;
  int flexibilidad;

  Times({this.calentamiento, this.desarrollo, this.vcalma, this.flexibilidad});

  Times.fromJson(Map<String, dynamic> json) {
    calentamiento = json['calentamiento'];
    desarrollo = json['desarrollo'];
    vcalma = json['vcalma'];
    flexibilidad = json['flexibilidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calentamiento'] = this.calentamiento;
    data['desarrollo'] = this.desarrollo;
    data['vcalma'] = this.vcalma;
    data['flexibilidad'] = this.flexibilidad;
    return data;
  }
}

class Exercises {
  String exerciseId;
  String videoName;
  String exerciseName;
  List<int> levels;
  List<String> stages;
  String exerciseNameAudioId;
  String recomendationAudioId;
  String ubication;
  String recomendation;
  List<String> categories;
  String sId;
  num metsPerMinute;

  Exercises(
      {this.exerciseId,
      this.videoName,
      this.exerciseName,
      this.levels,
      this.stages,
      this.exerciseNameAudioId,
      this.recomendationAudioId,
      this.ubication,
      this.recomendation,
      this.categories,
      this.sId,
      this.metsPerMinute});

  Exercises.fromJson(Map<String, dynamic> json) {
    exerciseId = json['exerciseId'];
    videoName = json['videoName'];
    exerciseName = json['exerciseName'];
    levels = json['levels'].cast<int>();
    stages = json['stages'].cast<String>();
    exerciseNameAudioId = json['exerciseNameAudioId'];
    recomendationAudioId = json['recomendationAudioId'];
    ubication = json['ubication'];
    recomendation = json['recomendation'];
    categories = json['categories'].cast<String>();
    sId = json['_id'];
    metsPerMinute = json['metsPerMinute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exerciseId'] = this.exerciseId;
    data['videoName'] = this.videoName;
    data['exerciseName'] = this.exerciseName;
    data['levels'] = this.levels;
    data['stages'] = this.stages;
    data['exerciseNameAudioId'] = this.exerciseNameAudioId;
    data['recomendationAudioId'] = this.recomendationAudioId;
    data['ubication'] = this.ubication;
    data['recomendation'] = this.recomendation;
    data['categories'] = this.categories;
    data['_id'] = this.sId;
    data['metsPerMinute'] = this.metsPerMinute;
    return data;
  }
}

class Tips {
  String audioId;
  String sId;
  String tipId;
  String tip;
  Questions questions;
  List<Audios> audios;

  Tips(
      {this.audioId,
      this.sId,
      this.tipId,
      this.tip,
      this.questions,
      this.audios});

  Tips.fromJson(Map<String, dynamic> json) {
    audioId = json['audioId'];
    sId = json['_id'];
    tipId = json['tipId'];
    tip = json['tip'];
    questions = json['questions'] != null
        ? new Questions.fromJson(json['questions'])
        : null;
    if (json['audios'] != null) {
      audios = new List<Audios>();
      json['audios'].forEach((v) {
        audios.add(new Audios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioId'] = this.audioId;
    data['_id'] = this.sId;
    data['tipId'] = this.tipId;
    data['tip'] = this.tip;
    if (this.questions != null) {
      data['questions'] = this.questions.toJson();
    }
    if (this.audios != null) {
      data['audios'] = this.audios.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  Alternatives alternatives;
  String sId;
  String questionVf;
  String correctVf;
  String questionAl;
  String correctAl;

  Questions(
      {this.alternatives,
      this.sId,
      this.questionVf,
      this.correctVf,
      this.questionAl,
      this.correctAl});

  Questions.fromJson(Map<String, dynamic> json) {
    alternatives = json['alternatives'] != null
        ? new Alternatives.fromJson(json['alternatives'])
        : null;
    sId = json['_id'];
    questionVf = json['questionVf'];
    correctVf = json['correctVf'];
    questionAl = json['questionAl'];
    correctAl = json['correctAl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alternatives != null) {
      data['alternatives'] = this.alternatives.toJson();
    }
    data['_id'] = this.sId;
    data['questionVf'] = this.questionVf;
    data['correctVf'] = this.correctVf;
    data['questionAl'] = this.questionAl;
    data['correctAl'] = this.correctAl;
    return data;
  }
}

class Alternatives {
  String a;
  String b;
  String c;

  Alternatives({this.a, this.b, this.c});

  Alternatives.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    c = json['c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    return data;
  }
}

class Audios {
  String link;
  String type;

  Audios({this.link, this.type});

  Audios.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['type'] = this.type;
    return data;
  }
}

class Pauses {
  List<String> tips;
  int micro;
  int macro;

  Pauses({this.tips, this.micro, this.macro});

  Pauses.fromJson(Map<String, dynamic> json) {
    tips = json['tips'].cast<String>();
    micro = json['micro'];
    macro = json['macro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tips'] = this.tips;
    data['micro'] = this.micro;
    data['macro'] = this.macro;
    return data;
  }
}

class Questionnaire {
  String id;
  String type;

  Questionnaire({this.id, this.type});

  Questionnaire.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
