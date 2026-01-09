import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool isDark = SharedPref.isDark();

  void changeTheme() {
    isDark = !isDark;
    SharedPref.setIsDark(isDark);
    emit(ThemeChanged());
  }
}
