class Component {
  final String id;
  final String name;
  final String sensorType;
  final String status;
  final String? parentId;
  final String? locationId;

  Component({
    required this.id,
    required this.name,
    required this.sensorType,
    required this.status,
    this.parentId,
    this.locationId,
  });
}
