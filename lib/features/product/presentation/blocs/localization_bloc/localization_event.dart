part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends LocalizationEvent {
  final Locale newLocale;
  const ChangeLanguageEvent(this.newLocale);

  @override
  List<Object> get props => [newLocale];
}
