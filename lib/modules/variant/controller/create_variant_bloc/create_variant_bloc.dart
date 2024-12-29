import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/errors/failure.dart';
import '/utils/errors_model.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/create_variant_state_model.dart';
import '../../repository/variant_repository.dart';

part 'create_variant_event.dart';

part 'create_variant_state.dart';

class CreateVariantBloc
    extends Bloc<CreateVariantEvent, CreateVariantStateModel> {
  final VariantRepository _variantRepository;
  final LoginBloc _loginBloc;

  CreateVariantBloc(
      {required VariantRepository variantRepository,
      required LoginBloc loginBloc})
      : _variantRepository = variantRepository,
        _loginBloc = loginBloc,
        super(const CreateVariantStateModel()) {
    on<CreateVariantNameEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<CreateVariantStatusEvent>((event, emit) {
      emit(state.copyWith(status: event.status));
    });
    on<CreateVariantProductIdEvent>((event, emit) {
      emit(state.copyWith(productId: event.productId));
    });

    on<CreateVariantSubmitWithIdEvent>(_submitVariantEvent);
    // on<UpdateVariantSubmitEventWithId>(_updateVariantSubmitEvent);
  }

  Future<void> _submitVariantEvent(CreateVariantSubmitWithIdEvent event,
      Emitter<CreateVariantStateModel> emit) async {
    emit(state.copyWith(createState: const CreateVariantLoading()));
    final body = state;
    print('VariantBody: $body');
    final result = await _variantRepository.createVariantProduct(
        _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final error = CreateVariantFormValidate(failure.errors);
        emit(state.copyWith(createState: error));
      } else {
        final errorState =
            CreateVariantError(failure.message, failure.statusCode);
        emit(state.copyWith(createState: errorState));
      }
    }, (created) {
      emit(state.copyWith(createState: CreateVariantLoaded(created)));
      // emit(
      //   state.copyWith(
      //     name: '',
      //     status: '',
      //     productId: '',
      //     createState: const CreateVariantLoaded('Created Successfully'),
      //   ),
      // );
      emit(state.clear());
    });
  }
}
