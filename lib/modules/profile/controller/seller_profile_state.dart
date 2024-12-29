part of 'seller_profile_cubit.dart';

abstract class SellerProfileState extends Equatable {
  const SellerProfileState();

  @override
  List<Object> get props => [];
}

class SellerProfileStateLoading extends SellerProfileState {}

class SellerProfileStateLoaded extends SellerProfileState {
  final SellerProfileModel sellerProfile;

  const SellerProfileStateLoaded(this.sellerProfile);

  @override
  List<Object> get props => [sellerProfile];
}

class SellerProfileStateError extends SellerProfileState {
  final String message;
  final int statusCode;

  const SellerProfileStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
