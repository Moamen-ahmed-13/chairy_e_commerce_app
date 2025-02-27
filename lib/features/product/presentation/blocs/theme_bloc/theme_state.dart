part of 'theme_bloc.dart';


abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ThemeInitial extends ThemeState {
ThemeInitial() : super(ThemeMode.light);}
class ThemeLoadedState extends ThemeState {
const ThemeLoadedState(ThemeMode themeMode) : super(themeMode);}

