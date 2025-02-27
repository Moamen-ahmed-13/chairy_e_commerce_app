import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<LoadThemeEvent>(_onLoadTheme);
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', event.themeMode == ThemeMode.dark);
    emit(ThemeLoadedState(event.themeMode));
  }

  Future<void> _onLoadTheme(
      LoadThemeEvent event, Emitter<ThemeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(ThemeLoadedState(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}
