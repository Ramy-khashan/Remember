import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/shared_preferences_const.dart';
import '../../../core/utils/shared_prefrance_utils.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  bool isActive =
      PreferenceUtils.getString(SharedPreferencesConst.withNotification) == "no"
          ? false
          : true;
  changeNotificationState({required bool value}) async {
    await PreferenceUtils.setString(
        SharedPreferencesConst.withNotification, value ? "yes" : "no");
    isActive =
        PreferenceUtils.getString(SharedPreferencesConst.withNotification) ==
                "no"
            ? false
            : true;
    emit(ChangeNotificationState());
  }
}
