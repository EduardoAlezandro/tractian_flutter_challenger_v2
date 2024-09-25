
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.id,
    required super.name,
    super.parentId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }
}
