class Plant {
  final String? uid;
  final String name;
  final String? photoURL;
  final Map<String, Object?> wateringDetails;
  final Map<String, Object?> mistingDetails;
  final Map<String, Object?> feedingDetails;

  Plant({
    this.uid,
    required this.name,
    required this.photoURL,
    required this.wateringDetails,
    required this.mistingDetails,
    required this.feedingDetails,
  });

  Map<String, Object?> toJson() {
    return {
      PlantFields.uid: uid,
      PlantFields.name: name,
      PlantFields.photoURL: photoURL,
      PlantFields.wateringDetails: wateringDetails,
      PlantFields.mistingDetails: mistingDetails,
      PlantFields.feedingDetails: feedingDetails,
    };
  }

  static Plant fromJson(json) {
    return Plant(
      uid: json[PlantFields.uid] as String?,
      name: json[PlantFields.name] as String,
      photoURL: json[PlantFields.photoURL] as String?,
      wateringDetails: json[PlantFields.wateringDetails] as Map<String, Object?>,
      mistingDetails: json[PlantFields.mistingDetails] as Map<String, Object?>,
      feedingDetails: json[PlantFields.feedingDetails] as Map<String, Object?>,
    );
  }

  Plant copy({
    String? uid,
    String? name,
    String? photoURL,
    Map<String, Object>? wateringDetails,
    Map<String, Object>? mistingDetails,
    Map<String, Object>? feedingDetails,
  }) =>
      Plant(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        photoURL: photoURL ?? this.photoURL,
        wateringDetails: wateringDetails ?? this.wateringDetails,
        mistingDetails: mistingDetails ?? this.mistingDetails,
        feedingDetails: feedingDetails ?? this.feedingDetails,
      );
}

class PlantFields {
  static String uid = 'uid';
  static String name = 'name';
  static String photoURL = 'photoURL';
  static String wateringDetails = 'wateringDetails';
  static String mistingDetails = 'mistingDetails';
  static String feedingDetails = 'feedingDetails';
}