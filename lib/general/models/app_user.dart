import 'package:plant_care/general/models/models.dart';

class AppUser {
  final String? uid;
  final String name;
  final String initials;
  final String email;
  final String? photoUrl;
  final List<String> plantUids;

  AppUser({
    this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.initials,
    required this.plantUids,
  });

  // to json
  Map<String, Object?> toJSON() {
    return {
      AppUserFields.uid: uid,
      AppUserFields.email: email,
      AppUserFields.name: name,
      AppUserFields.photoUrl: photoUrl,
      AppUserFields.initials: initials,
      AppUserFields.plantUids: plantUids,
    };
  }

  // from json
  static AppUser fromJson(json) {
    List<dynamic> plantUids = json[AppUserFields.plantUids];
    List<String> newPlantUids = List<String>.from(plantUids);
    return AppUser(
      uid: json[AppUserFields.uid] as String?,
      name: json[AppUserFields.name] as String,
      email: json[AppUserFields.email] as String,
      photoUrl: json[AppUserFields.photoUrl] as String?,
      initials: json[AppUserFields.initials] as String,
      plantUids: newPlantUids,
    );
  }

  // copy
  AppUser copy({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? initials,
    List<String>? plantUids,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      initials: initials ?? this.initials,
      plantUids: plantUids ?? this.plantUids,
    );
  }
}

class AppUserFields {
  static String uid = 'uid';
  static String name = 'name';
  static String email = 'email';
  static String photoUrl = 'photoUrl';
  static String initials = 'initials';
  static String plantUids = 'plantUids';
}
