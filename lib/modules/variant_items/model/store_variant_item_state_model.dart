
import 'package:equatable/equatable.dart';

import '../controller/store_variant_items_cubit/store_variant_item_cubit.dart';

class StoreVIStateModel extends Equatable {
  final String name;
  final String productId;
  final String variantId;
  final String price;
  final String status;
  final StoreVIState itemState;

  const StoreVIStateModel(
      {this.name = '',
      this.productId = '',
      this.variantId = '',
      this.price = '',
      this.status = '',
      this.itemState = const StoreVIInitial()});

  StoreVIStateModel copyWith({
    String? name,
    String? productId,
    String? variantId,
    String? price,
    String? status,
    StoreVIState? itemState,
  }) {
    return StoreVIStateModel(
      name: name ?? this.name,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      price: price ?? this.price,
      status: status ?? this.status,
      itemState: itemState ?? this.itemState, //ggg
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

  StoreVIStateModel clear() {
    return const StoreVIStateModel(
      name: '',
      productId: '',
      variantId: '',
      price: '',
      status: '',
      itemState: StoreVIInitial(),
    );
  }

  //
  // factory StoreVIStateModel.fromMap(Map<String, dynamic> map) {
  //   return StoreVIStateModel(
  //     name: map['name'] ?? '',
  //     productId: map['product_id'] ?? '',
  //     variantId: map['variant_id'] ?? '',
  //     price: map['price'] ?? '',
  //     status: map['status'] ?? '',
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory StoreVIStateModel.fromJson(String source) =>
  //     StoreVIStateModel.fromMap(json.decode(source) as Map<String, dynamic>);
  //
  // @override
  // bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      productId,
      variantId,
      price,
      status,
      itemState,
    ];
  }
}
