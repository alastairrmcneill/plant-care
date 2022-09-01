class Plant {
  final String? uid;
  final String name;
  final String? photoURL;

  Plant({
    this.uid,
    required this.name,
    this.photoURL,
  });

  Map<String, Object?> toJson() {
    return {
      PlantFeilds.uid: uid,
      PlantFeilds.name: name,
      PlantFeilds.photoURL: photoURL,
    };
  }

  static Plant fromJson(json) {
    return Plant(
      uid: json[PlantFeilds.uid] as String?,
      name: json[PlantFeilds.name] as String,
      photoURL: json[PlantFeilds.photoURL] as String?,
    );
  }

  Plant copy({
    String? uid,
    String? name,
    String? photoURL,
  }) =>
      Plant(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        photoURL: photoURL ?? this.photoURL,
      );
}

class PlantFeilds {
  static String uid = 'uid';
  static String name = 'name';
  static String photoURL = 'photoURL';
}
