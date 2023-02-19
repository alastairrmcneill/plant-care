import 'package:plant_care/general/models/models.dart';

class AppUser {
  final String? uid;
  final String name;
  final String initials;
  final String? photoUrl;
  final String token;

  AppUser({
    this.uid,
    required this.name,
    this.photoUrl,
    required this.initials,
    required this.token,
  });

  // to json
  Map<String, Object?> toJSON() {
    return {
      AppUserFields.uid: uid,
      AppUserFields.name: name,
      AppUserFields.photoUrl: photoUrl,
      AppUserFields.initials: initials,
      AppUserFields.token: token,
    };
  }

  // from json
  static AppUser fromJson(json) {
    return AppUser(
      uid: json[AppUserFields.uid] as String?,
      name: json[AppUserFields.name] as String,
      photoUrl: json[AppUserFields.photoUrl] as String?,
      initials: json[AppUserFields.initials] as String,
      token: json[AppUserFields.token] as String,
    );
  }

  // copy
  AppUser copy({
    String? uid,
    String? name,
    String? photoUrl,
    String? initials,
    String? token,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      initials: initials ?? this.initials,
      token: token ?? this.token,
    );
  }
}

class AppUserFields {
  static String uid = 'uid';
  static String name = 'name';
  static String photoUrl = 'photoUrl';
  static String initials = 'initials';
  static String token = 'token';
}
