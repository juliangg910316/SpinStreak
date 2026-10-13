// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionData {

 Duration get tiempo; double get distancia; int get calorias; double get odometro; int? get velocidadMax; int? get pulsoMax; String? get nota;
/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDataCopyWith<SessionData> get copyWith => _$SessionDataCopyWithImpl<SessionData>(this as SessionData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionData&&(identical(other.tiempo, _this.tiempo) || other.tiempo == _this.tiempo)&&(identical(other.distancia, _this.distancia) || other.distancia == _this.distancia)&&(identical(other.calorias, _this.calorias) || other.calorias == _this.calorias)&&(identical(other.odometro, _this.odometro) || other.odometro == _this.odometro)&&(identical(other.velocidadMax, _this.velocidadMax) || other.velocidadMax == _this.velocidadMax)&&(identical(other.pulsoMax, _this.pulsoMax) || other.pulsoMax == _this.pulsoMax)&&(identical(other.nota, _this.nota) || other.nota == _this.nota));
}


@override
int get hashCode {
  final _this = this as SessionData;
  return Object.hash(runtimeType,_this.tiempo,_this.distancia,_this.calorias,_this.odometro,_this.velocidadMax,_this.pulsoMax,_this.nota);
}

@override
String toString() {
  final _this = this as SessionData;
  return 'SessionData(tiempo: ${_this.tiempo}, distancia: ${_this.distancia}, calorias: ${_this.calorias}, odometro: ${_this.odometro}, velocidadMax: ${_this.velocidadMax}, pulsoMax: ${_this.pulsoMax}, nota: ${_this.nota})';
}


}

/// @nodoc
abstract mixin class $SessionDataCopyWith<$Res>  {
  factory $SessionDataCopyWith(SessionData value, $Res Function(SessionData) _then) = _$SessionDataCopyWithImpl;
@useResult
$Res call({
 Duration tiempo, double distancia, int calorias, double odometro, int? velocidadMax, int? pulsoMax, String? nota
});




}
/// @nodoc
class _$SessionDataCopyWithImpl<$Res>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._self, this._then);

  final SessionData _self;
  final $Res Function(SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tiempo = null,Object? distancia = null,Object? calorias = null,Object? odometro = null,Object? velocidadMax = freezed,Object? pulsoMax = freezed,Object? nota = freezed,}) {
  return _then(SessionData(
tiempo: null == tiempo ? _self.tiempo : tiempo // ignore: cast_nullable_to_non_nullable
as Duration,distancia: null == distancia ? _self.distancia : distancia // ignore: cast_nullable_to_non_nullable
as double,calorias: null == calorias ? _self.calorias : calorias // ignore: cast_nullable_to_non_nullable
as int,odometro: null == odometro ? _self.odometro : odometro // ignore: cast_nullable_to_non_nullable
as double,velocidadMax: freezed == velocidadMax ? _self.velocidadMax : velocidadMax // ignore: cast_nullable_to_non_nullable
as int?,pulsoMax: freezed == pulsoMax ? _self.pulsoMax : pulsoMax // ignore: cast_nullable_to_non_nullable
as int?,nota: freezed == nota ? _self.nota : nota // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionData].
extension SessionDataPatterns on SessionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionData value)  $default,){
final _that = this;
switch (_that) {
case _SessionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionData value)?  $default,){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)  $default,) {final _that = this;
switch (_that) {
case _SessionData():
return $default(_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)?  $default,) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
  return null;

}
}

}

/// @nodoc


class _SessionData implements SessionData {
  const _SessionData({required this.tiempo, required this.distancia, required this.calorias, required this.odometro, this.velocidadMax, this.pulsoMax, this.nota});
  

@override final  Duration tiempo;
@override final  double distancia;
@override final  int calorias;
@override final  double odometro;
@override final  int? velocidadMax;
@override final  int? pulsoMax;
@override final  String? nota;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDataCopyWith<_SessionData> get copyWith => __$SessionDataCopyWithImpl<_SessionData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionData&&(identical(other.tiempo, tiempo) || other.tiempo == tiempo)&&(identical(other.distancia, distancia) || other.distancia == distancia)&&(identical(other.calorias, calorias) || other.calorias == calorias)&&(identical(other.odometro, odometro) || other.odometro == odometro)&&(identical(other.velocidadMax, velocidadMax) || other.velocidadMax == velocidadMax)&&(identical(other.pulsoMax, pulsoMax) || other.pulsoMax == pulsoMax)&&(identical(other.nota, nota) || other.nota == nota));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tiempo,distancia,calorias,odometro,velocidadMax,pulsoMax,nota);
}

@override
String toString() {
    return 'SessionData(tiempo: $tiempo, distancia: $distancia, calorias: $calorias, odometro: $odometro, velocidadMax: $velocidadMax, pulsoMax: $pulsoMax, nota: $nota)';
}


}

/// @nodoc
abstract mixin class _$SessionDataCopyWith<$Res> implements $SessionDataCopyWith<$Res> {
  factory _$SessionDataCopyWith(_SessionData value, $Res Function(_SessionData) _then) = __$SessionDataCopyWithImpl;
@override @useResult
$Res call({
 Duration tiempo, double distancia, int calorias, double odometro, int? velocidadMax, int? pulsoMax, String? nota
});




}
/// @nodoc
class __$SessionDataCopyWithImpl<$Res>
    implements _$SessionDataCopyWith<$Res> {
  __$SessionDataCopyWithImpl(this._self, this._then);

  final _SessionData _self;
  final $Res Function(_SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tiempo = null,Object? distancia = null,Object? calorias = null,Object? odometro = null,Object? velocidadMax = freezed,Object? pulsoMax = freezed,Object? nota = freezed,}) {
  return _then(_SessionData(
tiempo: null == tiempo ? _self.tiempo : tiempo // ignore: cast_nullable_to_non_nullable
as Duration,distancia: null == distancia ? _self.distancia : distancia // ignore: cast_nullable_to_non_nullable
as double,calorias: null == calorias ? _self.calorias : calorias // ignore: cast_nullable_to_non_nullable
as int,odometro: null == odometro ? _self.odometro : odometro // ignore: cast_nullable_to_non_nullable
as double,velocidadMax: freezed == velocidadMax ? _self.velocidadMax : velocidadMax // ignore: cast_nullable_to_non_nullable
as int?,pulsoMax: freezed == pulsoMax ? _self.pulsoMax : pulsoMax // ignore: cast_nullable_to_non_nullable
as int?,nota: freezed == nota ? _self.nota : nota // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
