import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityByStateModel extends Equatable {
  final int id;
  final int countryStateId;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;

  const CityByStateModel({
    required this.id,
    required this.countryStateId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CityByStateModel copyWith({
    int? id,
    int? countryStateId,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CityByStateModel(
      id: id ?? this.id,
      countryStateId: countryStateId ?? this.countryStateId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country_state_id': countryStateId,
      'name': name,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CityByStateModel.fromMap(Map<String, dynamic> map) {
    return CityByStateModel(
      id: map['id'] ?? 0,
      countryStateId: map['country_state_id'] != null
          ? int.parse(map['country_state_id'].toString())
          : 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityByStateModel.fromJson(String source) =>
      CityByStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      countryStateId,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
