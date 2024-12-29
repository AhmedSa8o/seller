import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/login/login_bloc/login_bloc.dart';
import '../model/dashboard_model.dart';
import '../repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;
  final LoginBloc _loginBloc;
  DashboardModel? dashboardModel;

  DashboardCubit(
      {required DashboardRepository dashboardRepository,
      required LoginBloc loginBloc})
      : _dashboardRepository = dashboardRepository,
        _loginBloc = loginBloc,
        super(DashboardStateLoading());

  Future<void> getDashboardData() async {
    final result = await _dashboardRepository
        .getDashboardData(_loginBloc.userInformation!.accessToken);
    result.fold(
      (failure) {
        emit(DashboardStateError(failure.message, failure.statusCode));
      },
      (data) {
        dashboardModel = data;
        emit(DashboardStateLoaded(dashboardModel: data));
      },
    );
  }
}
