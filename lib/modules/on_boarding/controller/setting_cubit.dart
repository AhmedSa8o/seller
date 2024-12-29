import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/website_setup_model.dart';
import '/modules/on_boarding/model/setting_model.dart';
import '../../splash/repository/setting_repository.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepository _settingRepository;
  WebsiteSetupModel? settingModel;

  SettingCubit({required SettingRepository settingRepository})
      : _settingRepository = settingRepository,
        super(const SettingInitial()) {
    getSetting();
  }

  bool get showOnBoarding =>
      _settingRepository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<void> cacheOnBoarding() async {
    final result = await _settingRepository.cachedOnBoarding();
    result.fold((l) => false, (r) => r);
  }

  Future<void> getSetting() async {
    emit(const SettingStateLoading());
    final result = await _settingRepository.getSetting();
    result.fold((failure) {
      emit(SettingStateError(failure.message, failure.statusCode));
    }, (success) {
      settingModel = success;
      emit(SettingStateLoaded(success));
    });
  }
}
