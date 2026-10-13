// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dia_historial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaHistorial {

/// Día local (sin hora), el mismo que usa la racha.
 DateTime get dia;/// Sesiones del día, de la más reciente a la más antigua.
 List<Session> get sesiones; double get distanciaTotal; Duration get tiempoTotal; int get caloriasTotal;
/// Create a copy of DiaHistorial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaHistorialCopyWith<DiaHistorial> get copyWith => _$DiaHistorialCopyWithImpl<DiaHistorial>(this as DiaHistorial, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiaHistorial;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaHistorial&&(identical(other.dia, _this.dia) || other.dia == _this.dia)&&const DeepCollectionEquality().equals(other.sesiones, _this.sesiones)&&(identical(other.distanciaTotal, _this.distanciaTotal) || other.distanciaTotal == _this.distanciaTotal)&&(identical(other.tiempoTotal, _this.tiempoTotal) || other.tiempoTotal == _this.tiempoTotal)&&(identical(other.caloriasTotal, _this.caloriasTotal) || other.caloriasTotal == _this.caloriasTotal));
}


@override
int get hashCode {
  final _this = this as DiaHistorial;
  return Object.hash(runtimeType,_this.dia,const DeepCollectionEquality().hash(_this.sesiones),_this.distanciaTotal,_this.tiempoTotal,_this.caloriasTotal);
}

@override
String toString() {
  final _this = this as DiaHistorial;
  return 'DiaHistorial(dia: ${_this.dia}, sesiones: ${_this.sesiones}, distanciaTotal: ${_this.distanciaTotal}, tiempoTotal: ${_this.tiempoTotal}, caloriasTotal: ${_this.caloriasTotal})';
}


}

/// @nodoc
abstract mixin class $DiaHistorialCopyWith<$Res>  {
  factory $DiaHistorialCopyWith(DiaHistorial value, $Res Function(DiaHistorial) _then) = _$DiaHistorialCopyWithImpl;
@useResult
$Res call({
 DateTime dia, List<Session> sesiones, double distanciaTotal, Duration tiempoTotal, int caloriasTotal
});




}
/// @nodoc
class _$DiaHistorialCopyWithImpl<$Res>
    implements $DiaHistorialCopyWith<$Res> {
  _$DiaHistorialCopyWithImpl(this._self, this._then);

  final DiaHistorial _self;
  final $Res Function(DiaHistorial) _then;

/// Create a copy of DiaHistorial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dia = null,Object? sesiones = null,Object? distanciaTotal = null,Object? tiempoTotal = null,Object? caloriasTotal = null,}) {
  return _then(DiaHistorial(
dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,sesiones: null == sesiones ? _self.sesiones : sesiones // ignore: cast_nullable_to_non_nullable
as List<Session>,distanciaTotal: null == distanciaTotal ? _self.distanciaTotal : distanciaTotal // ignore: cast_nullable_to_non_nullable
as double,tiempoTotal: null == tiempoTotal ? _self.tiempoTotal : tiempoTotal // ignore: cast_nullable_to_non_nullable
as Duration,caloriasTotal: null == caloriasTotal ? _self.caloriasTotal : caloriasTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaHistorial].
extension DiaHistorialPatterns on DiaHistorial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaHistorial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaHistorial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaHistorial value)  $default,){
final _that = this;
switch (_that) {
case _DiaHistorial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaHistorial value)?  $default,){
final _that = this;
switch (_that) {
case _DiaHistorial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dia,  List<Session> sesiones,  double distanciaTotal,  Duration tiempoTotal,  int caloriasTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaHistorial() when $default != null:
return $default(_that.dia,_that.sesiones,_that.distanciaTotal,_that.tiempoTotal,_that.caloriasTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dia,  List<Session> sesiones,  double distanciaTotal,  Duration tiempoTotal,  int caloriasTotal)  $default,) {final _that = this;
switch (_that) {
case _DiaHistorial():
return $default(_that.dia,_that.sesiones,_that.distanciaTotal,_that.tiempoTotal,_that.caloriasTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dia,  List<Session> sesiones,  double distanciaTotal,  Duration tiempoTotal,  int caloriasTotal)?  $default,) {final _that = this;
switch (_that) {
case _DiaHistorial() when $default != null:
return $default(_that.dia,_that.sesiones,_that.distanciaTotal,_that.tiempoTotal,_that.caloriasTotal);case _:
  return null;

}
}

}

/// @nodoc


class _DiaHistorial extends DiaHistorial {
  const _DiaHistorial({required this.dia, required  List<Session> sesiones, required this.distanciaTotal, required this.tiempoTotal, required this.caloriasTotal}): _sesiones = sesiones,super._();
  

/// Día local (sin hora), el mismo que usa la racha.
@override final  DateTime dia;
/// Sesiones del día, de la más reciente a la más antigua.
 final  List<Session> _sesiones;
/// Sesiones del día, de la más reciente a la más antigua.
@override List<Session> get sesiones {
  if (_sesiones is EqualUnmodifiableListView) return _sesiones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sesiones);
}

@override final  double distanciaTotal;
@override final  Duration tiempoTotal;
@override final  int caloriasTotal;

/// Create a copy of DiaHistorial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaHistorialCopyWith<_DiaHistorial> get copyWith => __$DiaHistorialCopyWithImpl<_DiaHistorial>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaHistorial&&(identical(other.dia, dia) || other.dia == dia)&&const DeepCollectionEquality().equals(other.sesiones, _sesiones)&&(identical(other.distanciaTotal, distanciaTotal) || other.distanciaTotal == distanciaTotal)&&(identical(other.tiempoTotal, tiempoTotal) || other.tiempoTotal == tiempoTotal)&&(identical(other.caloriasTotal, caloriasTotal) || other.caloriasTotal == caloriasTotal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dia,const DeepCollectionEquality().hash(_sesiones),distanciaTotal,tiempoTotal,caloriasTotal);
}

@override
String toString() {
    return 'DiaHistorial(dia: $dia, sesiones: $sesiones, distanciaTotal: $distanciaTotal, tiempoTotal: $tiempoTotal, caloriasTotal: $caloriasTotal)';
}


}

/// @nodoc
abstract mixin class _$DiaHistorialCopyWith<$Res> implements $DiaHistorialCopyWith<$Res> {
  factory _$DiaHistorialCopyWith(_DiaHistorial value, $Res Function(_DiaHistorial) _then) = __$DiaHistorialCopyWithImpl;
@override @useResult
$Res call({
 DateTime dia, List<Session> sesiones, double distanciaTotal, Duration tiempoTotal, int caloriasTotal
});




}
/// @nodoc
class __$DiaHistorialCopyWithImpl<$Res>
    implements _$DiaHistorialCopyWith<$Res> {
  __$DiaHistorialCopyWithImpl(this._self, this._then);

  final _DiaHistorial _self;
  final $Res Function(_DiaHistorial) _then;

/// Create a copy of DiaHistorial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dia = null,Object? sesiones = null,Object? distanciaTotal = null,Object? tiempoTotal = null,Object? caloriasTotal = null,}) {
  return _then(_DiaHistorial(
dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,sesiones: null == sesiones ? _self._sesiones : sesiones // ignore: cast_nullable_to_non_nullable
as List<Session>,distanciaTotal: null == distanciaTotal ? _self.distanciaTotal : distanciaTotal // ignore: cast_nullable_to_non_nullable
as double,tiempoTotal: null == tiempoTotal ? _self.tiempoTotal : tiempoTotal // ignore: cast_nullable_to_non_nullable
as Duration,caloriasTotal: null == caloriasTotal ? _self.caloriasTotal : caloriasTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
