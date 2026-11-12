// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Paginated<T> {

 List<T> get content; int get totalElements; int get totalPages; int get numberOfElements; int get number;
/// Create a copy of Paginated
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedCopyWith<T, Paginated<T>> get copyWith => _$PaginatedCopyWithImpl<T, Paginated<T>>(this as Paginated<T>, _$identity);

  /// Serializes this Paginated to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  final _this = this as Paginated<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Paginated<T>&&const DeepCollectionEquality().equals(other.content, _this.content)&&(identical(other.totalElements, _this.totalElements) || other.totalElements == _this.totalElements)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.numberOfElements, _this.numberOfElements) || other.numberOfElements == _this.numberOfElements)&&(identical(other.number, _this.number) || other.number == _this.number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Paginated<T>;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.content),_this.totalElements,_this.totalPages,_this.numberOfElements,_this.number);
}

@override
String toString() {
  final _this = this as Paginated<T>;
  return 'Paginated<$T>(content: ${_this.content}, totalElements: ${_this.totalElements}, totalPages: ${_this.totalPages}, numberOfElements: ${_this.numberOfElements}, number: ${_this.number})';
}


}

/// @nodoc
abstract mixin class $PaginatedCopyWith<T,$Res>  {
  factory $PaginatedCopyWith(Paginated<T> value, $Res Function(Paginated<T>) _then) = _$PaginatedCopyWithImpl;
@useResult
$Res call({
 List<T> content, int totalElements, int totalPages, int numberOfElements, int number
});




}
/// @nodoc
class _$PaginatedCopyWithImpl<T,$Res>
    implements $PaginatedCopyWith<T, $Res> {
  _$PaginatedCopyWithImpl(this._self, this._then);

  final Paginated<T> _self;
  final $Res Function(Paginated<T>) _then;

/// Create a copy of Paginated
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? totalElements = null,Object? totalPages = null,Object? numberOfElements = null,Object? number = null,}) {
  return _then(Paginated(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<T>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,numberOfElements: null == numberOfElements ? _self.numberOfElements : numberOfElements // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Paginated].
extension PaginatedPatterns<T> on Paginated<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Paginated<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Paginated() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Paginated<T> value)  $default,){
final _that = this;
switch (_that) {
case _Paginated():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Paginated<T> value)?  $default,){
final _that = this;
switch (_that) {
case _Paginated() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> content,  int totalElements,  int totalPages,  int numberOfElements,  int number)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Paginated() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.numberOfElements,_that.number);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> content,  int totalElements,  int totalPages,  int numberOfElements,  int number)  $default,) {final _that = this;
switch (_that) {
case _Paginated():
return $default(_that.content,_that.totalElements,_that.totalPages,_that.numberOfElements,_that.number);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> content,  int totalElements,  int totalPages,  int numberOfElements,  int number)?  $default,) {final _that = this;
switch (_that) {
case _Paginated() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.numberOfElements,_that.number);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _Paginated<T> implements Paginated<T> {
  const _Paginated({ List<T> content = const [], this.totalElements = 0, this.totalPages = 0, this.numberOfElements = 0, this.number = 0}): _content = content;
  factory _Paginated.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PaginatedFromJson(json,fromJsonT);

 final  List<T> _content;
@override@JsonKey() List<T> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override@JsonKey() final  int totalElements;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int numberOfElements;
@override@JsonKey() final  int number;

/// Create a copy of Paginated
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedCopyWith<T, _Paginated<T>> get copyWith => __$PaginatedCopyWithImpl<T, _Paginated<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PaginatedToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paginated<T>&&const DeepCollectionEquality().equals(other.content, _content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.numberOfElements, numberOfElements) || other.numberOfElements == numberOfElements)&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),totalElements,totalPages,numberOfElements,number);
}

@override
String toString() {
    return 'Paginated<$T>(content: $content, totalElements: $totalElements, totalPages: $totalPages, numberOfElements: $numberOfElements, number: $number)';
}


}

/// @nodoc
abstract mixin class _$PaginatedCopyWith<T,$Res> implements $PaginatedCopyWith<T, $Res> {
  factory _$PaginatedCopyWith(_Paginated<T> value, $Res Function(_Paginated<T>) _then) = __$PaginatedCopyWithImpl;
@override @useResult
$Res call({
 List<T> content, int totalElements, int totalPages, int numberOfElements, int number
});




}
/// @nodoc
class __$PaginatedCopyWithImpl<T,$Res>
    implements _$PaginatedCopyWith<T, $Res> {
  __$PaginatedCopyWithImpl(this._self, this._then);

  final _Paginated<T> _self;
  final $Res Function(_Paginated<T>) _then;

/// Create a copy of Paginated
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? totalElements = null,Object? totalPages = null,Object? numberOfElements = null,Object? number = null,}) {
  return _then(_Paginated<T>(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<T>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,numberOfElements: null == numberOfElements ? _self.numberOfElements : numberOfElements // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
