class CourseData {
  final String courseId;
  final Map college;
  final String number;
  final String letter;
  final String year;

  CourseData(
      {this.courseId, this.college, this.number, this.letter, this.year});

  Map<String, dynamic> toMap() {
    return {
      'courseId': this.courseId,
      'college': this.college,
      'number': this.number,
      'letter': this.letter,
      'year': this.year
    };
  }

  factory CourseData.fromMap(Map<String, dynamic> map) {
    return CourseData(
        courseId: map['courseId'],
        college: map['college'],
        number: map['number'],
        letter: map['letter'],
        year: map['year']);
  }
}
