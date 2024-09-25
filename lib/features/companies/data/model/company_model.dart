// lib/features/companies/data/models/company_model.dart

import 'package:tractian_flutter_challenger_v2/features/companies/domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({required super.id, required super.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
