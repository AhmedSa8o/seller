import 'package:equatable/equatable.dart';
import '../controller/create_variant_bloc/create_variant_bloc.dart';

class CreateVariantStateModel extends Equatable {
  final String name;
  final String productId;
  final String status;
  final CreateVariantState createState;

  const CreateVariantStateModel({
    this.name = '',
    this.productId = '',
    this.status = '1',
    this.createState = const CreateVariantInitial(),
  });

  CreateVariantStateModel copyWith({
    String? name,
    String? productId,
    String? status,
    CreateVariantState? createState,
  }) {
    return CreateVariantStateModel(
      name: name ?? this.name,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      createState: createState ?? this.createState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'product_id': productId,
      'status': status,
    };
  }

  CreateVariantStateModel clear() {
    return const CreateVariantStateModel(
      name: '',
      productId: '',
      status: '1',
      createState: CreateVariantInitial(),
    );
  }

  @override
  List<Object> get props => [name, productId, status, createState];
}
