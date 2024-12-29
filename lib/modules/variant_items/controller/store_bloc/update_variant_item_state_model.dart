import 'dart:convert';

import 'package:equatable/equatable.dart';
import '/modules/variant_items/controller/store_bloc/update_variant_item_bloc.dart';

class UpdateVariantItemStateModel extends Equatable {
  final String name;
  final String productId;
  final String variantId;
  final String price;
  final String status;
  final UpdateVariantItemState updateVIState;

  const UpdateVariantItemStateModel(
      {this.name = '',
      this.productId = '',
      this.variantId = '',
      this.price = '',
      this.status = '',
      this.updateVIState = const UpdateVariantItemInitial()});

  UpdateVariantItemStateModel copyWith({
    String? name,
    String? productId,
    String? variantId,
    String? price,
    String? status,
    UpdateVariantItemState? updateVIState,
  }) {
    return UpdateVariantItemStateModel(
      name: name ?? this.name,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      price: price ?? this.price,
      status: status ?? this.status,
      updateVIState: updateVIState ?? this.updateVIState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'product_id': productId,
      'variant_id': variantId,
      'price': price,
      'status': status,
    };
  }

  UpdateVariantItemStateModel clear() {
    return const UpdateVariantItemStateModel(
      name: '',
      productId: '',
      variantId: '',
      price: '',
      status: '',
      updateVIState: UpdateVariantItemInitial(),
    );
  }

  factory UpdateVariantItemStateModel.fromMap(Map<String, dynamic> map) {
    return UpdateVariantItemStateModel(
      name: map['name'] ?? '',
      productId: map['product_id'] ?? '',
      variantId: map['variant_id'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateVariantItemStateModel.fromJson(String source) =>
      UpdateVariantItemStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      productId,
      variantId,
      price,
      status,
      updateVIState,
    ];
  }
}
