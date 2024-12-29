import 'package:equatable/equatable.dart';
import 'update_variant_cubit.dart';

class UpdateVariantStateModel extends Equatable {
  final String name;
  final String productId;
  final String status;
  final UpdateVariantState updateState;

  const UpdateVariantStateModel({
    this.name = '',
    this.productId = '',
    this.status = '',
    this.updateState = const UpdateVariantInitial(),
  });

  UpdateVariantStateModel copyWith({
    String? name,
    String? productId,
    String? status,
    UpdateVariantState? updateState,
  }) {
    return UpdateVariantStateModel(
      name: name ?? this.name,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      updateState: updateState ?? this.updateState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'product_id': productId,
      'status': status,
    };
  }

  UpdateVariantStateModel clear() {
    return const UpdateVariantStateModel(
      name: '',
      productId: '',
      status: '',
      updateState: UpdateVariantInitial(),
    );
  }

  @override
  List<Object> get props => [name, productId, status, updateState];
}
