part of 'category_brand_cubit.dart';

abstract class CategoryBrandState extends Equatable {
  const CategoryBrandState();

  @override
  List<Object> get props => [];
}

class CategoryBrandStateInitial extends CategoryBrandState {}
class CategoryBrandStateLoading extends CategoryBrandState {}

class CategoryBrandStateLoaded extends CategoryBrandState {
  final CategoryBrandModel categoryBrandModel;

  const CategoryBrandStateLoaded(this.categoryBrandModel);

  @override
  List<Object> get props => [categoryBrandModel];
}

class CategoryBrandStateError extends CategoryBrandState {
  final String message;
  final int statusCode;

  const CategoryBrandStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
