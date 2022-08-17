import 'package:plant_care/general/models/models.dart';

class AppUser {
  final String? uid;
  final String name;
  final String email;
  final String? photoUrl;

  AppUser({
    this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  // to json
  Map<String, Object?> toJSON() {
    return {
      AppUserFields.uid: uid,
      AppUserFields.email: email,
      AppUserFields.name: name,
      AppUserFields.photoUrl: photoUrl,
    };
  }

  // from json
  static AppUser fromJson(json) {
    return AppUser(
      uid: json[AppUserFields.uid] as String?,
      name: json[AppUserFields.name] as String,
      email: json[AppUserFields.email] as String,
      photoUrl: json[AppUserFields.photoUrl] as String?,
    );
  }

  // copy
  AppUser copy({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

class AppUserFields {
  static String uid = 'uid';
  static String name = 'name';
  static String email = 'email';
  static String photoUrl = 'photoUrl';
}
