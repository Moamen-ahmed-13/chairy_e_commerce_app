part of 'localization_bloc.dart';

abstract class LocalizationState extends Equatable {
  final Locale locale;
  const LocalizationState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocalizationInitial extends LocalizationState {
  const LocalizationInitial(Locale locale) : super(locale);
}

class LocalizationUpdated extends LocalizationState {
  const LocalizationUpdated(Locale locale) : super(locale);
}
