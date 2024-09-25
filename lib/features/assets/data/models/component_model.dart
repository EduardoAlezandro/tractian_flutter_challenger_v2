
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/component.dart';

class ComponentModel extends Component {
  ComponentModel({
    required super.id,
    required super.name,
    required super.sensorType,
    required super.status,
    super.parentId,
    super.locationId,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      sensorType: json['sensorType'],
      status: json['status'],
      parentId: json['parentId'],
      locationId: json['locationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sensorType': sensorType,
      'status': status,
      'parentId': parentId,
      'locationId': locationId,
    };
  }
}
