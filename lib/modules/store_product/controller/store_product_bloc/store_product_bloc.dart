import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/core/errors/failure.dart';
import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '../../repository/store_product_repository.dart';
import '/utils/errors_model.dart';

import '../../model/store_product_state_model.dart';

part 'store_product_event.dart';

part 'store_product_state.dart';

class StoreProductBloc extends Bloc<StoreProductEvent, StoreProductStateModel> {
  final StoreProductRepository _storeProductRepository;
  final LoginBloc _loginBloc;

  StoreProductBloc({
    required StoreProductRepository storeProductRepository,
    required LoginBloc loginBloc,
  })  : _storeProductRepository = storeProductRepository,
        _loginBloc = loginBloc,
        super(const StoreProductStateModel()) {
    on<StoreProductEventImage>((event, emit) {
      emit(state.copyWith(thumbImage: event.image));
    });

    on<StoreProductEventShortName>((event, emit) {
      emit(state.copyWith(shortName: event.shortName));
    });
    on<StoreProductEventName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<StoreProductEventSlug>((event, emit) {
      emit(state.copyWith(slug: event.slug));
    });
    on<StoreProductEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<StoreProductEventOfferPrice>((event, emit) {
      emit(state.copyWith(offerPrice: event.offerPrice));
    });

    on<StoreProductEventQuantity>((event, emit) {
      emit(state.copyWith(quantity: event.quantity));
    });
    on<StoreProductEventWeight>((event, emit) {
      emit(state.copyWith(weight: event.weight));
    });
    on<StoreProductEventShortDes>((event, emit) {
      emit(state.copyWith(shortDescription: event.shortDescription));
    });
    on<StoreProductEventLongDes>((event, emit) {
      emit(state.copyWith(longDescription: event.longDescription));
    });

    on<StoreProductEventCategory>((event, emit) {
      emit(state.copyWith(category: event.category));
    });

    on<StoreProductEventStatus>((event, emit) {
      emit(state.copyWith(status: event.id));
    });
/////start
    on<StoreProductEventSku>((event, emit) {
      emit(state.copyWith(sku: event.sku));
    });

    on<StoreProductEventTags>((event, emit) {
      emit(state.copyWith(tags: event.tags));
    });

    on<StoreProductEventSeoTitle>((event, emit) {
      emit(state.copyWith(seoTitle: event.seoTitle));
    });

    on<StoreProductEventSeoDescription>((event, emit) {
      emit(state.copyWith(seoDescription: event.seoDescription));
    });

    on<StoreProductEventTop>((event, emit) {
      emit(state.copyWith(isTop: event.isTop));
    });

    on<StoreProductEventNewProduct>((event, emit) {
      emit(state.copyWith(newProduct: event.newProduct));
    });
    on<StoreProductEventBest>((event, emit) {
      emit(state.copyWith(isBest: event.isBest));
    });
    on<StoreProductEventFeature>((event, emit) {
      emit(state.copyWith(isFeatured: event.isFeatured));
    });

    on<StoreProductEventSpecification>((event, emit) {
      emit(state.copyWith(isSpecification: event.isSpecification));
    });
    ////end

    on<StoreProductSubmitEvent>(_storeProductSubmit);
    on<StoreProductUpdateStatusEvent>(_updateProductStatus);
  }

  Future<void> _storeProductSubmit(StoreProductSubmitEvent event,
      Emitter<StoreProductStateModel> emit) async {
    emit(state.copyWith(state: StoreProductLoading()));
    final body = state;
    print(body);
    final result = await _storeProductRepository.storeProduct(
        body, _loginBloc.userInformation!.accessToken);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = StoreProductLoadFormValidate(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          emit(
            state.copyWith(
              state: StoreProductLoadError(failure.message, failure.statusCode),
            ),
          );
        }
      },
      (stored) {
        final success = StoreProductLoaded(stored);
        emit(state.copyWith(state: success));
        emit(state.clear());

      },
    );
  }

  Future<void> _updateProductStatus(StoreProductUpdateStatusEvent event,
      Emitter<StoreProductStateModel> emit) async {
    emit(state.copyWith(state: StoreProductLoading()));
    final result = await _storeProductRepository.updateProductStatus(
        event.id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      final errors = StoreProductLoadError(failure.message, failure.statusCode);
      emit(
        state.copyWith(state: errors),
      );
    }, (statusUpdated) {
      final success = StoreProductStatusUpdated(statusUpdated);
      emit(state.copyWith(state: success));
      // emit(state.clear());
    });
  }
}
