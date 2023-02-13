import 'package:plant_care/general/models/models.dart';

class Household {
  final String? uid;
  final String name;
  final String code;
  final List<String> members;
  final List<String> plants;
  final Map plantsInfo;
  final Map memberInfo;

  Household({
    this.uid,
    required this.name,
    required this.code,
    required this.members,
    required this.plants,
    required this.plantsInfo,
    required this.memberInfo,
  });

  Map<String, Object?> toJson() {
    return {
      HouseholdFields.uid: uid,
      HouseholdFields.name: name,
      HouseholdFields.code: code,
      HouseholdFields.members: members,
      HouseholdFields.plants: plants,
      HouseholdFields.plantsInfo: plantsInfo,
      HouseholdFields.memberInfo: memberInfo,
    };
  }

  static Household fromJson(json) {
    List<dynamic> members = json[HouseholdFields.members];
    List<String> newMembers = List<String>.from(members);
    List<dynamic> plants = json[HouseholdFields.plants];
    List<String> newPlants = List<String>.from(plants);
    return Household(
      uid: json[HouseholdFields.uid] as String?,
      name: json[HouseholdFields.name] as String,
      code: json[HouseholdFields.code] as String,
      members: newMembers,
      plants: newPlants,
      plantsInfo: json[HouseholdFields.plantsInfo] as Map,
      memberInfo: json[HouseholdFields.memberInfo] as Map,
    );
  }

  Household copy({
    String? uid,
    String? name,
    String? code,
    List<String>? members,
    List<String>? plants,
    Map? plantsInfo,
    Map? memberInfo,
  }) =>
      Household(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        code: code ?? this.code,
        members: members ?? this.members,
        plants: plants ?? this.plants,
        plantsInfo: plantsInfo ?? this.plantsInfo,
        memberInfo: memberInfo ?? this.memberInfo,
      );
}

class HouseholdFields {
  static String uid = 'uid';
  static String name = 'name';
  static String code = 'code';
  static String members = 'members';
  static String plants = 'plants';
  static String plantsInfo = 'plantsInfo';
  static String memberInfo = 'memberInfo';
}
