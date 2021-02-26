class GifData {
  final int id;
  //Name of Gif document
  final String name;
  //Duration of Gif
  final double gifduration;
  //Max Amont of Frames
  final int maxFrames;
  //If the Gif has some sort of animation
  final bool hasAnim;
  //KiloCalories Base Multiplier
  final int kiloCalories;
  //name Excercise
  final String nameExcercise;
  //Recomendattion
  final String recommendation;

  GifData(
      {this.id,
      this.name,
      this.gifduration,
      this.maxFrames,
      this.hasAnim,
      this.kiloCalories,
      this.nameExcercise,
      this.recommendation});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'gifduration': this.gifduration,
      'maxFrames': this.maxFrames,
      'hasAnim': this.hasAnim,
      'kiloCalories': kiloCalories,
      'nameExcercise': this.nameExcercise,
      'recommendation': this.recommendation
    };
  }

  factory GifData.fromMap(int id, Map<String, dynamic> map) {
    return GifData(
        id: id,
        name: map['name'],
        gifduration: map['gifduration'],
        maxFrames: map['maxFrames'],
        hasAnim: map['hasAnim'],
        kiloCalories: map['kiloCalories'],
        nameExcercise: map['nameExcercise'],
        recommendation: map['recommendation']);
  }

  GifData copyWith(
      {int id,
      String name,
      double gifduration,
      int maxFrames,
      bool hasAnim,
      int kiloCalories,
      String nameExcercise,
      String recommendation}) {
    return GifData(
        id: id ?? this.id,
        name: name ?? this.name,
        gifduration: gifduration ?? this.gifduration,
        maxFrames: maxFrames ?? this.maxFrames,
        hasAnim: hasAnim ?? this.hasAnim,
        kiloCalories: kiloCalories ?? this.kiloCalories,
        nameExcercise: nameExcercise ?? this.nameExcercise,
        recommendation: recommendation ?? this.recommendation);
  }
}
