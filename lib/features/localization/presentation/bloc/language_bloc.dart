import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/core/cache/cache.dart';

import '../../domain/entities/language.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));

    Prefs.setString(Prefs.LANGUAGE, event.selectedLanguage.value.languageCode);
  }
}
