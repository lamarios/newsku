// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String? get id; String? get username; String? get password; String? get email; String? get feedItemPreference; String? get oidcSub; int get minimumImportance; bool get firstTimeSetupDone; ReadItemHandling get readItemHandling; List<EmailDigestFrequency> get emailDigest;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as User;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.feedItemPreference, _this.feedItemPreference) || other.feedItemPreference == _this.feedItemPreference)&&(identical(other.oidcSub, _this.oidcSub) || other.oidcSub == _this.oidcSub)&&(identical(other.minimumImportance, _this.minimumImportance) || other.minimumImportance == _this.minimumImportance)&&(identical(other.firstTimeSetupDone, _this.firstTimeSetupDone) || other.firstTimeSetupDone == _this.firstTimeSetupDone)&&(identical(other.readItemHandling, _this.readItemHandling) || other.readItemHandling == _this.readItemHandling)&&const DeepCollectionEquality().equals(other.emailDigest, _this.emailDigest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as User;
  return Object.hash(runtimeType,_this.id,_this.username,_this.password,_this.email,_this.feedItemPreference,_this.oidcSub,_this.minimumImportance,_this.firstTimeSetupDone,_this.readItemHandling,const DeepCollectionEquality().hash(_this.emailDigest));
}

@override
String toString() {
  final _this = this as User;
  return 'User(id: ${_this.id}, username: ${_this.username}, password: ${_this.password}, email: ${_this.email}, feedItemPreference: ${_this.feedItemPreference}, oidcSub: ${_this.oidcSub}, minimumImportance: ${_this.minimumImportance}, firstTimeSetupDone: ${_this.firstTimeSetupDone}, readItemHandling: ${_this.readItemHandling}, emailDigest: ${_this.emailDigest})';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String? id, String? username, String? password, String? email, String? feedItemPreference, String? oidcSub, int minimumImportance, bool firstTimeSetupDone, ReadItemHandling readItemHandling, List<EmailDigestFrequency> emailDigest
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? username = freezed,Object? password = freezed,Object? email = freezed,Object? feedItemPreference = freezed,Object? oidcSub = freezed,Object? minimumImportance = null,Object? firstTimeSetupDone = null,Object? readItemHandling = null,Object? emailDigest = null,}) {
  return _then(User(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,feedItemPreference: freezed == feedItemPreference ? _self.feedItemPreference : feedItemPreference // ignore: cast_nullable_to_non_nullable
as String?,oidcSub: freezed == oidcSub ? _self.oidcSub : oidcSub // ignore: cast_nullable_to_non_nullable
as String?,minimumImportance: null == minimumImportance ? _self.minimumImportance : minimumImportance // ignore: cast_nullable_to_non_nullable
as int,firstTimeSetupDone: null == firstTimeSetupDone ? _self.firstTimeSetupDone : firstTimeSetupDone // ignore: cast_nullable_to_non_nullable
as bool,readItemHandling: null == readItemHandling ? _self.readItemHandling : readItemHandling // ignore: cast_nullable_to_non_nullable
as ReadItemHandling,emailDigest: null == emailDigest ? _self.emailDigest : emailDigest // ignore: cast_nullable_to_non_nullable
as List<EmailDigestFrequency>,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? username,  String? password,  String? email,  String? feedItemPreference,  String? oidcSub,  int minimumImportance,  bool firstTimeSetupDone,  ReadItemHandling readItemHandling,  List<EmailDigestFrequency> emailDigest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.password,_that.email,_that.feedItemPreference,_that.oidcSub,_that.minimumImportance,_that.firstTimeSetupDone,_that.readItemHandling,_that.emailDigest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? username,  String? password,  String? email,  String? feedItemPreference,  String? oidcSub,  int minimumImportance,  bool firstTimeSetupDone,  ReadItemHandling readItemHandling,  List<EmailDigestFrequency> emailDigest)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.username,_that.password,_that.email,_that.feedItemPreference,_that.oidcSub,_that.minimumImportance,_that.firstTimeSetupDone,_that.readItemHandling,_that.emailDigest);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? username,  String? password,  String? email,  String? feedItemPreference,  String? oidcSub,  int minimumImportance,  bool firstTimeSetupDone,  ReadItemHandling readItemHandling,  List<EmailDigestFrequency> emailDigest)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.password,_that.email,_that.feedItemPreference,_that.oidcSub,_that.minimumImportance,_that.firstTimeSetupDone,_that.readItemHandling,_that.emailDigest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({this.id, this.username, this.password, this.email, this.feedItemPreference, this.oidcSub, this.minimumImportance = 0, this.firstTimeSetupDone = false, this.readItemHandling = ReadItemHandling.none,  List<EmailDigestFrequency> emailDigest = const []}): _emailDigest = emailDigest;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String? id;
@override final  String? username;
@override final  String? password;
@override final  String? email;
@override final  String? feedItemPreference;
@override final  String? oidcSub;
@override@JsonKey() final  int minimumImportance;
@override@JsonKey() final  bool firstTimeSetupDone;
@override@JsonKey() final  ReadItemHandling readItemHandling;
 final  List<EmailDigestFrequency> _emailDigest;
@override@JsonKey() List<EmailDigestFrequency> get emailDigest {
  if (_emailDigest is EqualUnmodifiableListView) return _emailDigest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emailDigest);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.email, email) || other.email == email)&&(identical(other.feedItemPreference, feedItemPreference) || other.feedItemPreference == feedItemPreference)&&(identical(other.oidcSub, oidcSub) || other.oidcSub == oidcSub)&&(identical(other.minimumImportance, minimumImportance) || other.minimumImportance == minimumImportance)&&(identical(other.firstTimeSetupDone, firstTimeSetupDone) || other.firstTimeSetupDone == firstTimeSetupDone)&&(identical(other.readItemHandling, readItemHandling) || other.readItemHandling == readItemHandling)&&const DeepCollectionEquality().equals(other.emailDigest, _emailDigest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,password,email,feedItemPreference,oidcSub,minimumImportance,firstTimeSetupDone,readItemHandling,const DeepCollectionEquality().hash(_emailDigest));
}

@override
String toString() {
    return 'User(id: $id, username: $username, password: $password, email: $email, feedItemPreference: $feedItemPreference, oidcSub: $oidcSub, minimumImportance: $minimumImportance, firstTimeSetupDone: $firstTimeSetupDone, readItemHandling: $readItemHandling, emailDigest: $emailDigest)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? username, String? password, String? email, String? feedItemPreference, String? oidcSub, int minimumImportance, bool firstTimeSetupDone, ReadItemHandling readItemHandling, List<EmailDigestFrequency> emailDigest
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? username = freezed,Object? password = freezed,Object? email = freezed,Object? feedItemPreference = freezed,Object? oidcSub = freezed,Object? minimumImportance = null,Object? firstTimeSetupDone = null,Object? readItemHandling = null,Object? emailDigest = null,}) {
  return _then(_User(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,feedItemPreference: freezed == feedItemPreference ? _self.feedItemPreference : feedItemPreference // ignore: cast_nullable_to_non_nullable
as String?,oidcSub: freezed == oidcSub ? _self.oidcSub : oidcSub // ignore: cast_nullable_to_non_nullable
as String?,minimumImportance: null == minimumImportance ? _self.minimumImportance : minimumImportance // ignore: cast_nullable_to_non_nullable
as int,firstTimeSetupDone: null == firstTimeSetupDone ? _self.firstTimeSetupDone : firstTimeSetupDone // ignore: cast_nullable_to_non_nullable
as bool,readItemHandling: null == readItemHandling ? _self.readItemHandling : readItemHandling // ignore: cast_nullable_to_non_nullable
as ReadItemHandling,emailDigest: null == emailDigest ? _self._emailDigest : emailDigest // ignore: cast_nullable_to_non_nullable
as List<EmailDigestFrequency>,
  ));
}


}

// dart format on
