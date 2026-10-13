// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Session {

 int get id;/// Momento del registro. Lo asigna la app y no se puede cambiar.
 DateTime get fecha;/// Día local del registro (sin hora). Es la clave de la racha y del
/// agrupado del historial.
 DateTime get dia; Duration get tiempo;/// Kilómetros recorridos en la sesión (hasta 2 decimales).
 double get distancia;/// Estimación de la bici, en kcal.
 int get calorias;/// Total acumulado de la bici, en km (hasta 2 decimales).
 double get odometro;/// km/h, entero. Opcional.
 int? get velocidadMax;/// Pulsaciones por minuto. Opcional.
 int? get pulsoMax; String? get nota;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Session;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fecha, _this.fecha) || other.fecha == _this.fecha)&&(identical(other.dia, _this.dia) || other.dia == _this.dia)&&(identical(other.tiempo, _this.tiempo) || other.tiempo == _this.tiempo)&&(identical(other.distancia, _this.distancia) || other.distancia == _this.distancia)&&(identical(other.calorias, _this.calorias) || other.calorias == _this.calorias)&&(identical(other.odometro, _this.odometro) || other.odometro == _this.odometro)&&(identical(other.velocidadMax, _this.velocidadMax) || other.velocidadMax == _this.velocidadMax)&&(identical(other.pulsoMax, _this.pulsoMax) || other.pulsoMax == _this.pulsoMax)&&(identical(other.nota, _this.nota) || other.nota == _this.nota));
}


@override
int get hashCode {
  final _this = this as Session;
  return Object.hash(runtimeType,_this.id,_this.fecha,_this.dia,_this.tiempo,_this.distancia,_this.calorias,_this.odometro,_this.velocidadMax,_this.pulsoMax,_this.nota);
}

@override
String toString() {
  final _this = this as Session;
  return 'Session(id: ${_this.id}, fecha: ${_this.fecha}, dia: ${_this.dia}, tiempo: ${_this.tiempo}, distancia: ${_this.distancia}, calorias: ${_this.calorias}, odometro: ${_this.odometro}, velocidadMax: ${_this.velocidadMax}, pulsoMax: ${_this.pulsoMax}, nota: ${_this.nota})';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 int id, DateTime fecha, DateTime dia, Duration tiempo, double distancia, int calorias, double odometro, int? velocidadMax, int? pulsoMax, String? nota
});




}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fecha = null,Object? dia = null,Object? tiempo = null,Object? distancia = null,Object? calorias = null,Object? odometro = null,Object? velocidadMax = freezed,Object? pulsoMax = freezed,Object? nota = freezed,}) {
  return _then(Session(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fecha: null == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime,dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,tiempo: null == tiempo ? _self.tiempo : tiempo // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime fecha,  DateTime dia,  Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.fecha,_that.dia,_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime fecha,  DateTime dia,  Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.id,_that.fecha,_that.dia,_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime fecha,  DateTime dia,  Duration tiempo,  double distancia,  int calorias,  double odometro,  int? velocidadMax,  int? pulsoMax,  String? nota)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.fecha,_that.dia,_that.tiempo,_that.distancia,_that.calorias,_that.odometro,_that.velocidadMax,_that.pulsoMax,_that.nota);case _:
  return null;

}
}

}

/// @nodoc


class _Session extends Session {
  const _Session({required this.id, required this.fecha, required this.dia, required this.tiempo, required this.distancia, required this.calorias, required this.odometro, this.velocidadMax, this.pulsoMax, this.nota}): super._();
  

@override final  int id;
/// Momento del registro. Lo asigna la app y no se puede cambiar.
@override final  DateTime fecha;
/// Día local del registro (sin hora). Es la clave de la racha y del
/// agrupado del historial.
@override final  DateTime dia;
@override final  Duration tiempo;
/// Kilómetros recorridos en la sesión (hasta 2 decimales).
@override final  double distancia;
/// Estimación de la bici, en kcal.
@override final  int calorias;
/// Total acumulado de la bici, en km (hasta 2 decimales).
@override final  double odometro;
/// km/h, entero. Opcional.
@override final  int? velocidadMax;
/// Pulsaciones por minuto. Opcional.
@override final  int? pulsoMax;
@override final  String? nota;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.id, id) || other.id == id)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&(identical(other.dia, dia) || other.dia == dia)&&(identical(other.tiempo, tiempo) || other.tiempo == tiempo)&&(identical(other.distancia, distancia) || other.distancia == distancia)&&(identical(other.calorias, calorias) || other.calorias == calorias)&&(identical(other.odometro, odometro) || other.odometro == odometro)&&(identical(other.velocidadMax, velocidadMax) || other.velocidadMax == velocidadMax)&&(identical(other.pulsoMax, pulsoMax) || other.pulsoMax == pulsoMax)&&(identical(other.nota, nota) || other.nota == nota));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,fecha,dia,tiempo,distancia,calorias,odometro,velocidadMax,pulsoMax,nota);
}

@override
String toString() {
    return 'Session(id: $id, fecha: $fecha, dia: $dia, tiempo: $tiempo, distancia: $distancia, calorias: $calorias, odometro: $odometro, velocidadMax: $velocidadMax, pulsoMax: $pulsoMax, nota: $nota)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime fecha, DateTime dia, Duration tiempo, double distancia, int calorias, double odometro, int? velocidadMax, int? pulsoMax, String? nota
});




}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fecha = null,Object? dia = null,Object? tiempo = null,Object? distancia = null,Object? calorias = null,Object? odometro = null,Object? velocidadMax = freezed,Object? pulsoMax = freezed,Object? nota = freezed,}) {
  return _then(_Session(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fecha: null == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime,dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,tiempo: null == tiempo ? _self.tiempo : tiempo // ignore: cast_nullable_to_non_nullable
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
