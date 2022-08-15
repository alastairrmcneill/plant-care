class AppUser {
  final String? uid;

  AppUser({this.uid});

  // to json
  Map<String, Object?> toJSON() {
    return {
      AppUserFields.uid: uid,
    };
  }

  // from json
  static AppUser fromJson(json) {
    return AppUser(
      uid: json[AppUserFields.uid] as String?,
    );
  }

  // copy
  AppUser copy(
    String? uid,
  ) {
    return AppUser(
      uid: uid ?? this.uid,
    );
  }
}

class AppUserFields {
  static String uid = 'uid';
}
