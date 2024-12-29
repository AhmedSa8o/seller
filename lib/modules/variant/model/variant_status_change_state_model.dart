import 'package:equatable/equatable.dart';

import '../controller/variant_status_change/variant_status_change_cubit.dart';

class VariantStatusChangeStateModel extends Equatable {
  final String status;
  final VPStatusChangeState statusChangeState;

  const VariantStatusChangeStateModel({
    this.status = '1',
    this.statusChangeState = const VPStatusChangeInitial(),
  });

  VariantStatusChangeStateModel copyWith({
    String? status,
    VPStatusChangeState? statusChangeState,
  }) {
    return VariantStatusChangeStateModel(
      status: status ?? this.status,
      statusChangeState: statusChangeState ?? this.statusChangeState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'status': status,
    };
  }

  @override
  List<Object> get props => [status, statusChangeState];
}
