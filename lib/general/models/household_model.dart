import 'package:plant_care/general/models/models.dart';

class Household {
  final String? uid;
  final String name;
  final String code;
  final List<String> members;
  final Map plantsInfo;

  Household({
    this.uid,
    required this.name,
    required this.code,
    required this.members,
    required this.plantsInfo,
  });

  Map<String, Object?> toJson() {
    return {
      HouseholdFields.uid: uid,
      HouseholdFields.name: name,
      HouseholdFields.code: code,
      HouseholdFields.members: members,
      HouseholdFields.plantsInfo: plantsInfo,
    };
  }

  static Household fromJson(json) {
    List<dynamic> members = json[HouseholdFields.members];
    List<String> newMembers = List<String>.from(members);
    return Household(
      uid: json[HouseholdFields.uid] as String?,
      name: json[HouseholdFields.name] as String,
      code: json[HouseholdFields.code] as String,
      members: newMembers,
      plantsInfo: json[HouseholdFields.plantsInfo] as Map,
    );
  }

  Household copy({
    String? uid,
    String? name,
    String? code,
    List<String>? members,
    Map? plantsInfo,
  }) =>
      Household(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        code: code ?? this.code,
        members: members ?? this.members,
        plantsInfo: plantsInfo ?? this.plantsInfo,
      );
}

class HouseholdFields {
  static String uid = 'uid';
  static String name = 'name';
  static String code = 'code';
  static String members = 'members';
  static String plantsInfo = 'plantsInfo';
}
