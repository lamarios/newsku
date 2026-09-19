import 'dart:io';

import 'package:app/notifications/notification_handler.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_preferences.freezed.dart';

const _defaultColor = Colors.deepOrange;

const _brightness = 'brightness';
const _themeColor = 'theme-color';
const _dynamicColor = 'dynamic-color';
const _blackBackground = 'black-background';

class LocalPreferencesCubit extends Cubit<LocalPreferencesState> {
  LocalPreferencesCubit(super.initialState) {
    init();
  }

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    var colorValue = prefs.getInt(_themeColor);
    Color color = colorValue != null ? Color(colorValue) : _defaultColor;

    var dynamic = prefs.getBool(_dynamicColor);
    var blackbackground = prefs.getBool(_blackBackground);

    var density = prefs.getDouble('density');

    var notifications = prefs.getBool('notifications') ?? false;
    var notificationsFrequency = prefs.getInt('notifications-frequency') ?? 1;

    var theme = ThemeMode.values.where((v) => v.name == prefs.getString(_brightness)).firstOrNull ?? ThemeMode.system;

    // we save the system color scheme if any
    var systemColors = !kIsWeb && Platform.isAndroid
        ? (await DynamicColorPlugin.getCorePalette())?.toColorScheme()
        : null;

    emit(
      state.copyWith(
        themeColor: color,
        dynamicColor: dynamic ?? false,
        blackBackground: blackbackground ?? false,
        density: density ?? 4,
        theme: theme,
        notifications: notifications,
        notificationsFrequency: notificationsFrequency,
        systemColors: systemColors,
      ),
    );
  }

  Future<void> setDynamicColor(bool bool) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_dynamicColor, bool);
    emit(state.copyWith(dynamicColor: bool));
  }

  Future<void> setBrightness(ThemeMode theme) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_brightness, theme.name);
    emit(state.copyWith(theme: theme));
  }

  Future<void> setColor(Color color) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeColor, color.toARGB32());
    emit(state.copyWith(themeColor: color));
  }

  Future<void> setBlackBackground(bool bool) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_blackBackground, bool);
    emit(state.copyWith(blackBackground: bool));
  }

  Future<void> setDensity(double density) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setDouble('density', density);
    emit(state.copyWith(density: density));
  }

  Future<void> setNotifications(bool enabled) async {
    var prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(notifications: enabled));
    await prefs.setBool('notifications', enabled);
    NotificationHandler.setupNotifications();
  }

  Future<void> setNotificationsFrequency(int frequency) async {
    emit(state.copyWith(notificationsFrequency: frequency));
    EasyDebounce.debounce('set-notification-frequency', Duration(milliseconds: 500), () async {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setInt('notifications-frequency', frequency);
      NotificationHandler.setupNotifications();
    });
  }
}

@freezed
sealed class LocalPreferencesState with _$LocalPreferencesState {
  const factory LocalPreferencesState({
    @Default(_defaultColor) Color themeColor,
    @Default(false) bool dynamicColor,
    @Default(false) bool blackBackground,
    @Default(4) double density,
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(false) bool notifications,
    @Default(1) int notificationsFrequency,
    ColorScheme? systemColors,
  }) = _LocalPreferencesState;

  const LocalPreferencesState._();

  Color get appColor {
    return dynamicColor ? systemColors?.primary ?? themeColor : themeColor;
  }
}
