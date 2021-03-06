import 'models.dart';

class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> households;

  AppUser({
    this.uid = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    required this.households,
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'households': households,
    };
  }

  static AppUser fromJSON(json) {
    List<dynamic> households = json['households'];
    List<String> newHouseholds = List<String>.from(households);

    return AppUser(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      households: newHouseholds,
    );
  }

  AppUser copy({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    List<String>? households,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        households: households ?? this.households,
      );
}
