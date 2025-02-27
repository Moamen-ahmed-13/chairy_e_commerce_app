import 'package:chairy_e_commerce_app/features/product/presentation/blocs/localization_bloc/localization_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../blocs/theme_bloc/theme_bloc.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentLocale = context.locale.languageCode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 40, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'LOGO',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: mainColor,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  context.tr('menu'),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  context.tr('language'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                _buildLanguageOptions('ar', 'assets/images/ar.png',
                    currentLocale == 'ar', context),
                SizedBox(height: 10),
                Divider(height: 1),
                SizedBox(height: 10),
                _buildLanguageOptions('en', 'assets/images/en.png',
                    currentLocale == 'en', context),
              ],
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('theme'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                _buildThemeOption(
                    context.tr('light_mode'),
                    Icons.light_mode_rounded,
                    !isDarkMode,
                    themeBloc,
                    ThemeMode.light),
                SizedBox(height: 10),
                Divider(height: 1),
                SizedBox(height: 10),
                _buildThemeOption(
                    context.tr('dark_mode'),
                    Icons.dark_mode_rounded,
                    isDarkMode,
                    themeBloc,
                    ThemeMode.dark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String title, IconData icon, bool isSelected,
      ThemeBloc bloc, ThemeMode mode) {
    return GestureDetector(
      onTap: () {
        bloc.add(ToggleThemeEvent(mode));
      },
      child: Row(
        children: [
          Icon(isSelected ? Icons.check : null, color: mainColor),
          SizedBox(width: 10),
          Container(
            height: 20,
            width: 20,
            child: Icon(
              icon,
              color: mainColor,
            ),
          ),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildLanguageOptions(
      String lang, String asset, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LocalizationBloc>().add(ChangeLanguageEvent(Locale(lang)));
        context.setLocale(Locale(lang));
      },
      child: Row(
        children: [
          Icon(isSelected ? Icons.check : null, color: mainColor),
          SizedBox(width: 10),
          Container(height: 20, width: 20, child: Image.asset(asset)),
          SizedBox(width: 10),
          Text(lang.toUpperCase()),
        ],
      ),
    );
  }
}
