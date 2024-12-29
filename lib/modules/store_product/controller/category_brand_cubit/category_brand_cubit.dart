import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '/modules/store_product/model/category_brand_model.dart';

import '../../repository/store_product_repository.dart';

part 'category_brand_state.dart';

class CategoryBrandCubit extends Cubit<CategoryBrandState> {
  final StoreProductRepository _storeProductRepository;
  final LoginBloc _loginBloc;
  late CategoryBrandModel categoryBrandModel;

  CategoryBrandCubit(
      {required StoreProductRepository storeProductRepository,
      required LoginBloc loginBloc})
      : _storeProductRepository = storeProductRepository,
        _loginBloc = loginBloc,
        super(CategoryBrandStateInitial());

  Future<void> getAllCategoryAndBrands() async {
    emit(CategoryBrandStateLoading());
    final result = await _storeProductRepository
        .getAllCategoryAndBrands(_loginBloc.userInformation!.accessToken);
    result.fold(
      (f) => emit(CategoryBrandStateError(f.message, f.statusCode)),
      (r) {
        categoryBrandModel = r;
        emit(CategoryBrandStateLoaded(r));
      },
    );
  }
}
