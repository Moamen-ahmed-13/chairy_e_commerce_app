part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
 final ThemeMode themeMode; 
 const ToggleThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class LoadThemeEvent extends ThemeEvent {}
