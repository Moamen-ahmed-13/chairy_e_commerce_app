import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial(Locale('en', ''))) {
    on<ChangeLanguageEvent>((event, emit) {
    emit(LocalizationUpdated(event.newLocale));
  });
}

  Stream<Locale> mapEventToState(Localization_Event event) async* {
    if (event is ChangeLanguage_Event) {
      yield event.newLocale;

      // تحديث SharedPreferences لحفظ اللغة
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', event.newLocale.languageCode);
    }
  }
}
abstract class Localization_Event {}

class ChangeLanguage_Event extends Localization_Event {
  final Locale newLocale;
  ChangeLanguage_Event(this.newLocale);
}