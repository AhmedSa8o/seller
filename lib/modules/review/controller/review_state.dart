part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewStateLoading extends ReviewState {}

class ReviewListStateLoaded extends ReviewState {
  final List<ReviewModel> reviews;

  const ReviewListStateLoaded({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class ReviewModelStateLoaded extends ReviewState {
  final ReviewModel reviews;

  const ReviewModelStateLoaded({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class ReviewStateError extends ReviewState {
  final String message;
  final int statusCode;

  const ReviewStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
