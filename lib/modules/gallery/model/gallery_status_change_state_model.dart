import 'package:equatable/equatable.dart';

import '../controller/status_change_cubit/status_change_cubit.dart';

class GalleryStatusChangeStateModel extends Equatable {
  final int id;
  final String productId;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final StatusChangeState statusState;

  const GalleryStatusChangeStateModel({
    this.id = 0,
    this.productId = '',
    this.image = '',
    this.status = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.statusState = const StatusChangeInitial(),
  });

  GalleryStatusChangeStateModel copyWith({
    int? id,
    String? productId,
    String? image,
    String? status,
    String? createdAt,
    String? updatedAt,
    StatusChangeState? statusState,
  }) {
    return GalleryStatusChangeStateModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      statusState: statusState ?? this.statusState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      productId,
      image,
      status,
      createdAt,
      updatedAt,
      statusState,
    ];
  }
}
