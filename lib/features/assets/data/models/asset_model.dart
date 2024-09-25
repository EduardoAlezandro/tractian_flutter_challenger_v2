// lib/features/assets/data/models/asset_model.dart


import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/asset.dart';

class AssetModel extends Asset {
  AssetModel({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    super.sensorType,
    super.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'].toString(),
      name: json['name'],
      parentId: json['parentId']?.toString(),
      locationId: json['locationId']?.toString(),
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'locationId': locationId,
      'sensorType': sensorType,
      'status': status,
    };
  }
}
