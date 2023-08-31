class UserFields {
  static final String id = 'id';
  static final String childName = 'childName';
  static final String isBoy = 'isBoy';
  static final String rightHanded = 'rightHanded';
  static final String age = 'Age';
  static final String testerName = 'testerName';
  static final String kinderGardenName = 'kinderGardenName';
  static final String testType = 'testType';
  static final String correctAnswers = 'correctAnswers';
  static final String wrongAnswers = 'wrongAnswers';

  static List<String> getFields() => [
        id,
        childName,
        isBoy,
        rightHanded,
        age,
        testerName,
        kinderGardenName,
        testType,
        correctAnswers,
        wrongAnswers
      ];
}

class User {
  final int? id;
  final String childName;
  final bool isBoy;
  final bool rightHanded;
  final String age;
  final String testerName;
  final String kinderGardenName;
  final String testType;
  final int correctAnswers;
  final int wrongAnswers;

  const User({
    this.id,
    required this.childName,
    required this.isBoy,
    required this.rightHanded,
    required this.age,
    required this.testerName,
    required this.kinderGardenName,
    required this.testType,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  User copy({
    int? id,
    String? childName,
    bool? isBoy,
    bool? rightHanded,
    String? age,
    String? testerName,
    String? kinderGardenName,
    String? testType,
    int? correctAnswers,
    int? wrongAnswers,
  }) =>
      User(
        id: id ?? this.id,
        childName: childName ?? this.childName,
        isBoy: isBoy ?? this.isBoy,
        rightHanded: rightHanded ?? this.rightHanded,
        age: age ?? this.age,
        testerName: testerName ?? this.testerName,
        kinderGardenName: kinderGardenName ?? this.kinderGardenName,
        testType: testType ?? this.testType,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.childName: childName,
        UserFields.isBoy: isBoy,
        UserFields.rightHanded: rightHanded,
        UserFields.age: age,
        UserFields.testerName: testerName,
        UserFields.kinderGardenName: kinderGardenName,
        UserFields.testType: testType,
        UserFields.correctAnswers: correctAnswers,
        UserFields.wrongAnswers: wrongAnswers,
      };
}
