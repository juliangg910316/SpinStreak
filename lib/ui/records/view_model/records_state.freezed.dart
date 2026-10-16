// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordsState {

 RecordsStatus get status;/// Los cuatro récords, en el orden de `TipoRecord` (RF-1).
 List<RecordPersonal> get records;/// No hay ninguna sesión (RF-4).
 bool get sinSesiones;
/// Create a copy of RecordsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordsStateCopyWith<RecordsState> get copyWith => _$RecordsStateCopyWithImpl<RecordsState>(this as RecordsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecordsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.records, _this.records)&&(identical(other.sinSesiones, _this.sinSesiones) || other.sinSesiones == _this.sinSesiones));
}


@override
int get hashCode {
  final _this = this as RecordsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.records),_this.sinSesiones);
}

@override
String toString() {
  final _this = this as RecordsState;
  return 'RecordsState(status: ${_this.status}, records: ${_this.records}, sinSesiones: ${_this.sinSesiones})';
}


}

/// @nodoc
abstract mixin class $RecordsStateCopyWith<$Res>  {
  factory $RecordsStateCopyWith(RecordsState value, $Res Function(RecordsState) _then) = _$RecordsStateCopyWithImpl;
@useResult
$Res call({
 RecordsStatus status, List<RecordPersonal> records, bool sinSesiones
});




}
/// @nodoc
class _$RecordsStateCopyWithImpl<$Res>
    implements $RecordsStateCopyWith<$Res> {
  _$RecordsStateCopyWithImpl(this._self, this._then);

  final RecordsState _self;
  final $Res Function(RecordsState) _then;

/// Create a copy of RecordsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? records = null,Object? sinSesiones = null,}) {
  return _then(RecordsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordsStatus,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<RecordPersonal>,sinSesiones: null == sinSesiones ? _self.sinSesiones : sinSesiones // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecordsState].
extension RecordsStatePatterns on RecordsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordsState value)  $default,){
final _that = this;
switch (_that) {
case _RecordsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordsState value)?  $default,){
final _that = this;
switch (_that) {
case _RecordsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecordsStatus status,  List<RecordPersonal> records,  bool sinSesiones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordsState() when $default != null:
return $default(_that.status,_that.records,_that.sinSesiones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecordsStatus status,  List<RecordPersonal> records,  bool sinSesiones)  $default,) {final _that = this;
switch (_that) {
case _RecordsState():
return $default(_that.status,_that.records,_that.sinSesiones);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecordsStatus status,  List<RecordPersonal> records,  bool sinSesiones)?  $default,) {final _that = this;
switch (_that) {
case _RecordsState() when $default != null:
return $default(_that.status,_that.records,_that.sinSesiones);case _:
  return null;

}
}

}

/// @nodoc


class _RecordsState implements RecordsState {
  const _RecordsState({this.status = RecordsStatus.loading,  List<RecordPersonal> records = const [], this.sinSesiones = false}): _records = records;
  

@override@JsonKey() final  RecordsStatus status;
/// Los cuatro récords, en el orden de `TipoRecord` (RF-1).
 final  List<RecordPersonal> _records;
/// Los cuatro récords, en el orden de `TipoRecord` (RF-1).
@override@JsonKey() List<RecordPersonal> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

/// No hay ninguna sesión (RF-4).
@override@JsonKey() final  bool sinSesiones;

/// Create a copy of RecordsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordsStateCopyWith<_RecordsState> get copyWith => __$RecordsStateCopyWithImpl<_RecordsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.records, _records)&&(identical(other.sinSesiones, sinSesiones) || other.sinSesiones == sinSesiones));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_records),sinSesiones);
}

@override
String toString() {
    return 'RecordsState(status: $status, records: $records, sinSesiones: $sinSesiones)';
}


}

/// @nodoc
abstract mixin class _$RecordsStateCopyWith<$Res> implements $RecordsStateCopyWith<$Res> {
  factory _$RecordsStateCopyWith(_RecordsState value, $Res Function(_RecordsState) _then) = __$RecordsStateCopyWithImpl;
@override @useResult
$Res call({
 RecordsStatus status, List<RecordPersonal> records, bool sinSesiones
});




}
/// @nodoc
class __$RecordsStateCopyWithImpl<$Res>
    implements _$RecordsStateCopyWith<$Res> {
  __$RecordsStateCopyWithImpl(this._self, this._then);

  final _RecordsState _self;
  final $Res Function(_RecordsState) _then;

/// Create a copy of RecordsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? records = null,Object? sinSesiones = null,}) {
  return _then(_RecordsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordsStatus,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<RecordPersonal>,sinSesiones: null == sinSesiones ? _self.sinSesiones : sinSesiones // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
