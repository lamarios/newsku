import 'package:freezed_annotation/freezed_annotation.dart';

part 'newsku_error.freezed.dart';

part 'newsku_error.g.dart';

@freezed
sealed class NewskuError with _$NewskuError implements Error {
  @Implements<Error>()
  const factory NewskuError({
    required ErrorType type,
    required String? uuid,
    @Default("") String message,
    @JsonKey(includeToJson: false, includeFromJson: false) StackTrace? stackTrace,
  }) = _NewskuError;

  const NewskuError._();

  factory NewskuError.fromJson(Map<String, Object?> json) => _$NewskuErrorFromJson(json);
}

enum ErrorType { NewskuUserException, NewskuException }
