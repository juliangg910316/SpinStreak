// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_personal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordPersonal {

 TipoRecord get tipo;/// Sesión que tiene el récord (la más antigua si hay empate, RF-6), o
/// `null` si ninguna sesión tiene ese dato ("Sin datos", RF-3, RF-4).
 Session? get sesion;
/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordPersonalCopyWith<RecordPersonal> get copyWith => _$RecordPersonalCopyWithImpl<RecordPersonal>(this as RecordPersonal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecordPersonal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordPersonal&&(identical(other.tipo, _this.tipo) || other.tipo == _this.tipo)&&(identical(other.sesion, _this.sesion) || other.sesion == _this.sesion));
}


@override
int get hashCode {
  final _this = this as RecordPersonal;
  return Object.hash(runtimeType,_this.tipo,_this.sesion);
}

@override
String toString() {
  final _this = this as RecordPersonal;
  return 'RecordPersonal(tipo: ${_this.tipo}, sesion: ${_this.sesion})';
}


}

/// @nodoc
abstract mixin class $RecordPersonalCopyWith<$Res>  {
  factory $RecordPersonalCopyWith(RecordPersonal value, $Res Function(RecordPersonal) _then) = _$RecordPersonalCopyWithImpl;
@useResult
$Res call({
 TipoRecord tipo, Session? sesion
});


$SessionCopyWith<$Res>? get sesion;

}
/// @nodoc
class _$RecordPersonalCopyWithImpl<$Res>
    implements $RecordPersonalCopyWith<$Res> {
  _$RecordPersonalCopyWithImpl(this._self, this._then);

  final RecordPersonal _self;
  final $Res Function(RecordPersonal) _then;

/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tipo = null,Object? sesion = freezed,}) {
  return _then(RecordPersonal(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoRecord,sesion: freezed == sesion ? _self.sesion : sesion // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}
/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get sesion {
    if (_self.sesion == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.sesion!, (value) {
    return _then(_self.copyWith(sesion: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecordPersonal].
extension RecordPersonalPatterns on RecordPersonal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordPersonal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordPersonal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordPersonal value)  $default,){
final _that = this;
switch (_that) {
case _RecordPersonal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordPersonal value)?  $default,){
final _that = this;
switch (_that) {
case _RecordPersonal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TipoRecord tipo,  Session? sesion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordPersonal() when $default != null:
return $default(_that.tipo,_that.sesion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TipoRecord tipo,  Session? sesion)  $default,) {final _that = this;
switch (_that) {
case _RecordPersonal():
return $default(_that.tipo,_that.sesion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TipoRecord tipo,  Session? sesion)?  $default,) {final _that = this;
switch (_that) {
case _RecordPersonal() when $default != null:
return $default(_that.tipo,_that.sesion);case _:
  return null;

}
}

}

/// @nodoc


class _RecordPersonal implements RecordPersonal {
  const _RecordPersonal({required this.tipo, this.sesion});
  

@override final  TipoRecord tipo;
/// Sesión que tiene el récord (la más antigua si hay empate, RF-6), o
/// `null` si ninguna sesión tiene ese dato ("Sin datos", RF-3, RF-4).
@override final  Session? sesion;

/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordPersonalCopyWith<_RecordPersonal> get copyWith => __$RecordPersonalCopyWithImpl<_RecordPersonal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordPersonal&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.sesion, sesion) || other.sesion == sesion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tipo,sesion);
}

@override
String toString() {
    return 'RecordPersonal(tipo: $tipo, sesion: $sesion)';
}


}

/// @nodoc
abstract mixin class _$RecordPersonalCopyWith<$Res> implements $RecordPersonalCopyWith<$Res> {
  factory _$RecordPersonalCopyWith(_RecordPersonal value, $Res Function(_RecordPersonal) _then) = __$RecordPersonalCopyWithImpl;
@override @useResult
$Res call({
 TipoRecord tipo, Session? sesion
});


@override $SessionCopyWith<$Res>? get sesion;

}
/// @nodoc
class __$RecordPersonalCopyWithImpl<$Res>
    implements _$RecordPersonalCopyWith<$Res> {
  __$RecordPersonalCopyWithImpl(this._self, this._then);

  final _RecordPersonal _self;
  final $Res Function(_RecordPersonal) _then;

/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipo = null,Object? sesion = freezed,}) {
  return _then(_RecordPersonal(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoRecord,sesion: freezed == sesion ? _self.sesion : sesion // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}

/// Create a copy of RecordPersonal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get sesion {
    if (_self.sesion == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.sesion!, (value) {
    return _then(_self.copyWith(sesion: value));
  });
}
}

// dart format on
