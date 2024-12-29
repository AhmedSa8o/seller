import 'dart:convert';

import 'package:equatable/equatable.dart';

class StateByCountryModel extends Equatable {
  final int id;
  final int countryId;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;

  const StateByCountryModel({
    required this.id,
    required this.countryId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  StateByCountryModel copyWith({
    int? id,
    int? countryId,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return StateByCountryModel(
      id: id ?? this.id,
      countryId: countryId ?? this.countryId,
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
      'country_id': countryId,
      'name': name,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory StateByCountryModel.fromMap(Map<String, dynamic> map) {
    return StateByCountryModel(
      id: map['id'] ?? 0,
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StateByCountryModel.fromJson(String source) =>
      StateByCountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      countryId,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
