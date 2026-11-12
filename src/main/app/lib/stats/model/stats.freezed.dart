// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Stats {

 List<TagClick> get tagClicks; List<FeedClick> get feedClicks;
/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsCopyWith<Stats> get copyWith => _$StatsCopyWithImpl<Stats>(this as Stats, _$identity);

  /// Serializes this Stats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Stats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stats&&const DeepCollectionEquality().equals(other.tagClicks, _this.tagClicks)&&const DeepCollectionEquality().equals(other.feedClicks, _this.feedClicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Stats;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.tagClicks),const DeepCollectionEquality().hash(_this.feedClicks));
}

@override
String toString() {
  final _this = this as Stats;
  return 'Stats(tagClicks: ${_this.tagClicks}, feedClicks: ${_this.feedClicks})';
}


}

/// @nodoc
abstract mixin class $StatsCopyWith<$Res>  {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) _then) = _$StatsCopyWithImpl;
@useResult
$Res call({
 List<TagClick> tagClicks, List<FeedClick> feedClicks
});




}
/// @nodoc
class _$StatsCopyWithImpl<$Res>
    implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._self, this._then);

  final Stats _self;
  final $Res Function(Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tagClicks = null,Object? feedClicks = null,}) {
  return _then(Stats(
tagClicks: null == tagClicks ? _self.tagClicks : tagClicks // ignore: cast_nullable_to_non_nullable
as List<TagClick>,feedClicks: null == feedClicks ? _self.feedClicks : feedClicks // ignore: cast_nullable_to_non_nullable
as List<FeedClick>,
  ));
}

}


/// Adds pattern-matching-related methods to [Stats].
extension StatsPatterns on Stats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stats value)  $default,){
final _that = this;
switch (_that) {
case _Stats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stats value)?  $default,){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TagClick> tagClicks,  List<FeedClick> feedClicks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.tagClicks,_that.feedClicks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TagClick> tagClicks,  List<FeedClick> feedClicks)  $default,) {final _that = this;
switch (_that) {
case _Stats():
return $default(_that.tagClicks,_that.feedClicks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TagClick> tagClicks,  List<FeedClick> feedClicks)?  $default,) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.tagClicks,_that.feedClicks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stats implements Stats {
  const _Stats({ List<TagClick> tagClicks = const [],  List<FeedClick> feedClicks = const []}): _tagClicks = tagClicks,_feedClicks = feedClicks;
  factory _Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

 final  List<TagClick> _tagClicks;
@override@JsonKey() List<TagClick> get tagClicks {
  if (_tagClicks is EqualUnmodifiableListView) return _tagClicks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagClicks);
}

 final  List<FeedClick> _feedClicks;
@override@JsonKey() List<FeedClick> get feedClicks {
  if (_feedClicks is EqualUnmodifiableListView) return _feedClicks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feedClicks);
}


/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsCopyWith<_Stats> get copyWith => __$StatsCopyWithImpl<_Stats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stats&&const DeepCollectionEquality().equals(other.tagClicks, _tagClicks)&&const DeepCollectionEquality().equals(other.feedClicks, _feedClicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_tagClicks),const DeepCollectionEquality().hash(_feedClicks));
}

@override
String toString() {
    return 'Stats(tagClicks: $tagClicks, feedClicks: $feedClicks)';
}


}

/// @nodoc
abstract mixin class _$StatsCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$StatsCopyWith(_Stats value, $Res Function(_Stats) _then) = __$StatsCopyWithImpl;
@override @useResult
$Res call({
 List<TagClick> tagClicks, List<FeedClick> feedClicks
});




}
/// @nodoc
class __$StatsCopyWithImpl<$Res>
    implements _$StatsCopyWith<$Res> {
  __$StatsCopyWithImpl(this._self, this._then);

  final _Stats _self;
  final $Res Function(_Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tagClicks = null,Object? feedClicks = null,}) {
  return _then(_Stats(
tagClicks: null == tagClicks ? _self._tagClicks : tagClicks // ignore: cast_nullable_to_non_nullable
as List<TagClick>,feedClicks: null == feedClicks ? _self._feedClicks : feedClicks // ignore: cast_nullable_to_non_nullable
as List<FeedClick>,
  ));
}


}


/// @nodoc
mixin _$TagClick {

 String get tag; int get clicks;
/// Create a copy of TagClick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagClickCopyWith<TagClick> get copyWith => _$TagClickCopyWithImpl<TagClick>(this as TagClick, _$identity);

  /// Serializes this TagClick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TagClick;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagClick&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.clicks, _this.clicks) || other.clicks == _this.clicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TagClick;
  return Object.hash(runtimeType,_this.tag,_this.clicks);
}

@override
String toString() {
  final _this = this as TagClick;
  return 'TagClick(tag: ${_this.tag}, clicks: ${_this.clicks})';
}


}

/// @nodoc
abstract mixin class $TagClickCopyWith<$Res>  {
  factory $TagClickCopyWith(TagClick value, $Res Function(TagClick) _then) = _$TagClickCopyWithImpl;
@useResult
$Res call({
 String tag, int clicks
});




}
/// @nodoc
class _$TagClickCopyWithImpl<$Res>
    implements $TagClickCopyWith<$Res> {
  _$TagClickCopyWithImpl(this._self, this._then);

  final TagClick _self;
  final $Res Function(TagClick) _then;

/// Create a copy of TagClick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tag = null,Object? clicks = null,}) {
  return _then(TagClick(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,clicks: null == clicks ? _self.clicks : clicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TagClick].
extension TagClickPatterns on TagClick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagClick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagClick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagClick value)  $default,){
final _that = this;
switch (_that) {
case _TagClick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagClick value)?  $default,){
final _that = this;
switch (_that) {
case _TagClick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tag,  int clicks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagClick() when $default != null:
return $default(_that.tag,_that.clicks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tag,  int clicks)  $default,) {final _that = this;
switch (_that) {
case _TagClick():
return $default(_that.tag,_that.clicks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tag,  int clicks)?  $default,) {final _that = this;
switch (_that) {
case _TagClick() when $default != null:
return $default(_that.tag,_that.clicks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagClick implements TagClick {
  const _TagClick({required this.tag, required this.clicks});
  factory _TagClick.fromJson(Map<String, dynamic> json) => _$TagClickFromJson(json);

@override final  String tag;
@override final  int clicks;

/// Create a copy of TagClick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagClickCopyWith<_TagClick> get copyWith => __$TagClickCopyWithImpl<_TagClick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagClickToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagClick&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.clicks, clicks) || other.clicks == clicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tag,clicks);
}

@override
String toString() {
    return 'TagClick(tag: $tag, clicks: $clicks)';
}


}

/// @nodoc
abstract mixin class _$TagClickCopyWith<$Res> implements $TagClickCopyWith<$Res> {
  factory _$TagClickCopyWith(_TagClick value, $Res Function(_TagClick) _then) = __$TagClickCopyWithImpl;
@override @useResult
$Res call({
 String tag, int clicks
});




}
/// @nodoc
class __$TagClickCopyWithImpl<$Res>
    implements _$TagClickCopyWith<$Res> {
  __$TagClickCopyWithImpl(this._self, this._then);

  final _TagClick _self;
  final $Res Function(_TagClick) _then;

/// Create a copy of TagClick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tag = null,Object? clicks = null,}) {
  return _then(_TagClick(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,clicks: null == clicks ? _self.clicks : clicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FeedClick {

 Feed get feed; int get clicks;
/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedClickCopyWith<FeedClick> get copyWith => _$FeedClickCopyWithImpl<FeedClick>(this as FeedClick, _$identity);

  /// Serializes this FeedClick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeedClick;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedClick&&(identical(other.feed, _this.feed) || other.feed == _this.feed)&&(identical(other.clicks, _this.clicks) || other.clicks == _this.clicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeedClick;
  return Object.hash(runtimeType,_this.feed,_this.clicks);
}

@override
String toString() {
  final _this = this as FeedClick;
  return 'FeedClick(feed: ${_this.feed}, clicks: ${_this.clicks})';
}


}

/// @nodoc
abstract mixin class $FeedClickCopyWith<$Res>  {
  factory $FeedClickCopyWith(FeedClick value, $Res Function(FeedClick) _then) = _$FeedClickCopyWithImpl;
@useResult
$Res call({
 Feed feed, int clicks
});


$FeedCopyWith<$Res> get feed;

}
/// @nodoc
class _$FeedClickCopyWithImpl<$Res>
    implements $FeedClickCopyWith<$Res> {
  _$FeedClickCopyWithImpl(this._self, this._then);

  final FeedClick _self;
  final $Res Function(FeedClick) _then;

/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feed = null,Object? clicks = null,}) {
  return _then(FeedClick(
feed: null == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as Feed,clicks: null == clicks ? _self.clicks : clicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCopyWith<$Res> get feed {
  
  return $FeedCopyWith<$Res>(_self.feed, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedClick].
extension FeedClickPatterns on FeedClick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedClick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedClick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedClick value)  $default,){
final _that = this;
switch (_that) {
case _FeedClick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedClick value)?  $default,){
final _that = this;
switch (_that) {
case _FeedClick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Feed feed,  int clicks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedClick() when $default != null:
return $default(_that.feed,_that.clicks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Feed feed,  int clicks)  $default,) {final _that = this;
switch (_that) {
case _FeedClick():
return $default(_that.feed,_that.clicks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Feed feed,  int clicks)?  $default,) {final _that = this;
switch (_that) {
case _FeedClick() when $default != null:
return $default(_that.feed,_that.clicks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedClick implements FeedClick {
  const _FeedClick({required this.feed, required this.clicks});
  factory _FeedClick.fromJson(Map<String, dynamic> json) => _$FeedClickFromJson(json);

@override final  Feed feed;
@override final  int clicks;

/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedClickCopyWith<_FeedClick> get copyWith => __$FeedClickCopyWithImpl<_FeedClick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedClickToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedClick&&(identical(other.feed, feed) || other.feed == feed)&&(identical(other.clicks, clicks) || other.clicks == clicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,feed,clicks);
}

@override
String toString() {
    return 'FeedClick(feed: $feed, clicks: $clicks)';
}


}

/// @nodoc
abstract mixin class _$FeedClickCopyWith<$Res> implements $FeedClickCopyWith<$Res> {
  factory _$FeedClickCopyWith(_FeedClick value, $Res Function(_FeedClick) _then) = __$FeedClickCopyWithImpl;
@override @useResult
$Res call({
 Feed feed, int clicks
});


@override $FeedCopyWith<$Res> get feed;

}
/// @nodoc
class __$FeedClickCopyWithImpl<$Res>
    implements _$FeedClickCopyWith<$Res> {
  __$FeedClickCopyWithImpl(this._self, this._then);

  final _FeedClick _self;
  final $Res Function(_FeedClick) _then;

/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feed = null,Object? clicks = null,}) {
  return _then(_FeedClick(
feed: null == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as Feed,clicks: null == clicks ? _self.clicks : clicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FeedClick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCopyWith<$Res> get feed {
  
  return $FeedCopyWith<$Res>(_self.feed, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}

// dart format on
