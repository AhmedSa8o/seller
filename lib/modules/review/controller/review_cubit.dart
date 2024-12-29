import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '/modules/review/repository/review_repository.dart';

import '../model/review_model.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository _repository;
  final LoginBloc _loginBloc;
  List<ReviewModel>? reviewList;
  ReviewModel? reviewModel;

  ReviewCubit(
      {required ReviewRepository repository, required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(ReviewStateLoading());

  Future<void> getAllReviews() async {
    emit(ReviewStateLoading());
    final result = await _repository
        .getAllReviews(_loginBloc.userInformation!.accessToken);
    result.fold(
      (l) => emit(ReviewStateError(l.message, l.statusCode)),
      (reviewData) {
        reviewList = reviewData;
        emit(
          ReviewListStateLoaded(reviews: reviewData),
        );
      },
    );
  }

  Future<void> getAllReviewById(String id) async {
    emit(ReviewStateLoading());
    final result = await _repository.getAllReviewsById(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(ReviewStateError(failure.message, failure.statusCode));
    }, (review) {
      reviewModel = review;
      emit(ReviewModelStateLoaded(reviews: review));
    });
  }
}
