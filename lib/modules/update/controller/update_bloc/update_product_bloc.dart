import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/core/errors/failure.dart';
import 'package:seller_app/utils/errors_model.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/update_product_model_state.dart';
import '../../repository/update_repository.dart';

part 'update_product_event.dart';

part 'update_product_state.dart';

class UpdateProductBloc
    extends Bloc<UpdateProductEvent, UpdateProductModelState> {
  final UpdateProductRepository _updateProductRepository;
  final LoginBloc _loginBloc;

  UpdateProductBloc(
      {required UpdateProductRepository updateProductRepository,
      required LoginBloc loginBloc})
      : _updateProductRepository = updateProductRepository,
        _loginBloc = loginBloc,
        super(const UpdateProductModelState()) {
    on<UpdateProductEventShortName>((event, emit) {
      emit(state.copyWith(shortName: event.shortName));
    });

    on<UpdateProductEventImage>((event, emit) {
      emit(state.copyWith(thumbImage: event.image));
    });

    on<UpdateProductEventName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateProductEventSlug>((event, emit) {
      emit(state.copyWith(slug: event.slug));
    });

    on<UpdateProductEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });

    on<UpdateProductEventTop>((event, emit) {
      emit(state.copyWith(isTop: event.isTop));
    });
    on<UpdateProductEventNewArrivalProduct>((event, emit) {
      emit(state.copyWith(newProduct: event.newArrival));
    });
    on<UpdateProductEventBestProduct>((event, emit) {
      emit(state.copyWith(isBest: event.isBest));
    });
    on<UpdateProductEventFeatured>((event, emit) {
      emit(state.copyWith(isFeatured: event.isFeatured));
    });

    on<UpdateProductEventOfferPrice>((event, emit) {
      emit(state.copyWith(offerPrice: event.offerPrice));
    });

    on<UpdateProductEventQuantity>((event, emit) {
      emit(state.copyWith(quantity: event.quantity));
    });

    on<UpdateProductEventWeight>((event, emit) {
      emit(state.copyWith(weight: event.weight));
    });

    on<UpdateProductEventShortDes>((event, emit) {
      emit(state.copyWith(shortDescription: event.shortDescription));
    });

    on<UpdateProductEventLongDes>((event, emit) {
      emit(state.copyWith(longDescription: event.longDescription));
    });

    on<UpdateProductEventCategory>((event, emit) {
      emit(state.copyWith(category: event.category));
    });

    on<UpdateProductEventStatus>((event, emit) {
      emit(state.copyWith(status: event.id));
    });
    ///updating start

    on<UpdateProductEventSku>((event, emit) {
      emit(state.copyWith(sku: event.sku));
    });

    on<UpdateProductEventTags>((event, emit) {
      emit(state.copyWith(tags: event.tags));
    });

    on<UpdateProductEventSeoTitle>((event, emit) {
      emit(state.copyWith(seoTitle: event.seoTitle));
    });

    on<UpdateProductEventSeoDescription>((event, emit) {
      emit(state.copyWith(seoDescription: event.seoDescription));
    });

    // on<UpdateProductEventTop>((event, emit) {
    //   emit(state.copyWith(isTop: event.isTop));
    // });
    //
    // on<UpdateProductEventNewProduct>((event, emit) {
    //   emit(state.copyWith(newProduct: event.newProduct));
    // });
    // on<UpdateProductEventBest>((event, emit) {
    //   emit(state.copyWith(isBest: event.isBest));
    // });
    // on<UpdateProductEventFeature>((event, emit) {
    //   emit(state.copyWith(isFeatured: event.isFeatured));
    // });

    on<UpdateProductEventSpecification>((event, emit) {
      emit(state.copyWith(isSpecification: event.isSpecification));
    });
    ///updating end




    on<UpdateProductSubmitEvent>(_submitUpdate);
  }

  Future<void> _submitUpdate(UpdateProductSubmitEvent event,
      Emitter<UpdateProductModelState> emit) async {
    emit(state.copyWith(updateState: const UpdateProductLoading()));
    final body = state;

    print('BODY: $body');

    final result = await _updateProductRepository.updateSingleProduct(
        event.id.toString(), _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = UpdateProductFormValidate(failure.errors);
        emit(state.copyWith(updateState: errors));
      } else {
        emit(state.copyWith(
            updateState: UpdateProductError(failure.message, failure.statusCode)));
      }
    }, (data) {
      final success = UpdateProductLoaded(data);
      emit(state.copyWith(updateState: success));
      emit(state.clear());
    });
  }
}
