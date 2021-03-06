import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String uid;
  final String name;
  final String? latinName;
  final String? pictureURL;
  final Timestamp lastWateredDate;
  final Timestamp nextWaterDate;
  final int wateringFrequency;
  final String? notes;
  final String householdUID;
  final String householdName;
  final String? lastWateredBy;

  Plant({
    required this.uid,
    required this.name,
    this.latinName,
    this.pictureURL,
    required this.lastWateredDate,
    required this.nextWaterDate,
    required this.wateringFrequency,
    this.notes,
    required this.householdUID,
    required this.householdName,
    this.lastWateredBy,
  });

  Plant copy(
          {String? uid,
          String? name,
          String? latinName,
          String? pictureURL,
          Timestamp? lastWateredDate,
          Timestamp? nextWaterDate,
          int? wateringFrequency,
          String? notes,
          String? householdUID,
          String? householdName,
          String? lastWateredBy}) =>
      Plant(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        latinName: latinName ?? this.latinName,
        lastWateredDate: lastWateredDate ?? this.lastWateredDate,
        nextWaterDate: nextWaterDate ?? this.nextWaterDate,
        wateringFrequency: wateringFrequency ?? this.wateringFrequency,
        pictureURL: pictureURL ?? this.pictureURL,
        notes: notes ?? this.notes,
        householdUID: householdUID ?? this.householdUID,
        householdName: householdName ?? this.householdName,
        lastWateredBy: lastWateredBy ?? this.lastWateredBy,
      );

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'latinName': latinName,
      'pictureURL': pictureURL,
      'lastWateredDate': lastWateredDate,
      'nextWaterDate': nextWaterDate,
      'wateringFrequency': wateringFrequency,
      'notes': notes,
      'householdUID': householdUID,
      'householdName': householdName,
      'lastWateredBy': lastWateredBy,
    };
  }

  static Plant fromJSON(json) {
    return Plant(
      uid: json['uid'] as String,
      name: json['name'] as String,
      latinName: json['latinName'] as String?,
      lastWateredDate: json['lastWateredDate'] as Timestamp,
      nextWaterDate: json['nextWaterDate'] as Timestamp,
      wateringFrequency: json['wateringFrequency'] as int,
      pictureURL: json['pictureURL'] as String?,
      notes: json['notes'] as String?,
      householdUID: json['householdUID'] as String,
      householdName: json['householdName'] as String,
      lastWateredBy: json['lastWateredBy'] as String?,
    );
  }
}
