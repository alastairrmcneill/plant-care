class Household {
  final String? uid;
  final String name;

  Household({
    this.uid,
    required this.name,
  });

  Map<String, Object?> toJson() {
    return {
      HouseholdFields.uid: uid,
      HouseholdFields.name: name,
    };
  }

  static Household fromJson(json) {
    return Household(
      uid: json[HouseholdFields.uid] as String?,
      name: json[HouseholdFields.name] as String,
    );
  }

  Household copy({
    String? uid,
    String? name,
  }) =>
      Household(
        uid: uid ?? this.uid,
        name: name ?? this.name,
      );
}

class HouseholdFields {
  static String uid = 'uid';
  static String name = 'name';
}
