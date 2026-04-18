import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_block_settings.freezed.dart';
part 'layout_block_settings.g.dart';

@freezed
sealed class LayoutBlockSettings with _$LayoutBlockSettings {
  const factory LayoutBlockSettings({String? title, int? items, String? categoryId}) = _LayoutBlockSettings;

  factory LayoutBlockSettings.fromJson(Map<String, Object?> json) => _$LayoutBlockSettingsFromJson(json);
}
