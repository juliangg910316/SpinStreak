// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mes_calendario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MesCalendario {

/// Primer día del mes.
 DateTime get mes;/// Semanas de lunes a domingo, 7 celdas cada una. `null` es un hueco de
/// relleno (días del mes anterior o del siguiente).
 List<List<CeldaDia?>> get semanas;/// Si se puede pasar al mes siguiente: falso en el mes de hoy (RF-3).
 bool get puedeAvanzar;
/// Create a copy of MesCalendario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesCalendarioCopyWith<MesCalendario> get copyWith => _$MesCalendarioCopyWithImpl<MesCalendario>(this as MesCalendario, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MesCalendario;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesCalendario&&(identical(other.mes, _this.mes) || other.mes == _this.mes)&&const DeepCollectionEquality().equals(other.semanas, _this.semanas)&&(identical(other.puedeAvanzar, _this.puedeAvanzar) || other.puedeAvanzar == _this.puedeAvanzar));
}


@override
int get hashCode {
  final _this = this as MesCalendario;
  return Object.hash(runtimeType,_this.mes,const DeepCollectionEquality().hash(_this.semanas),_this.puedeAvanzar);
}

@override
String toString() {
  final _this = this as MesCalendario;
  return 'MesCalendario(mes: ${_this.mes}, semanas: ${_this.semanas}, puedeAvanzar: ${_this.puedeAvanzar})';
}


}

/// @nodoc
abstract mixin class $MesCalendarioCopyWith<$Res>  {
  factory $MesCalendarioCopyWith(MesCalendario value, $Res Function(MesCalendario) _then) = _$MesCalendarioCopyWithImpl;
@useResult
$Res call({
 DateTime mes, List<List<CeldaDia?>> semanas, bool puedeAvanzar
});




}
/// @nodoc
class _$MesCalendarioCopyWithImpl<$Res>
    implements $MesCalendarioCopyWith<$Res> {
  _$MesCalendarioCopyWithImpl(this._self, this._then);

  final MesCalendario _self;
  final $Res Function(MesCalendario) _then;

/// Create a copy of MesCalendario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mes = null,Object? semanas = null,Object? puedeAvanzar = null,}) {
  return _then(MesCalendario(
mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as DateTime,semanas: null == semanas ? _self.semanas : semanas // ignore: cast_nullable_to_non_nullable
as List<List<CeldaDia?>>,puedeAvanzar: null == puedeAvanzar ? _self.puedeAvanzar : puedeAvanzar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MesCalendario].
extension MesCalendarioPatterns on MesCalendario {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesCalendario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesCalendario() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesCalendario value)  $default,){
final _that = this;
switch (_that) {
case _MesCalendario():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesCalendario value)?  $default,){
final _that = this;
switch (_that) {
case _MesCalendario() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime mes,  List<List<CeldaDia?>> semanas,  bool puedeAvanzar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesCalendario() when $default != null:
return $default(_that.mes,_that.semanas,_that.puedeAvanzar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime mes,  List<List<CeldaDia?>> semanas,  bool puedeAvanzar)  $default,) {final _that = this;
switch (_that) {
case _MesCalendario():
return $default(_that.mes,_that.semanas,_that.puedeAvanzar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime mes,  List<List<CeldaDia?>> semanas,  bool puedeAvanzar)?  $default,) {final _that = this;
switch (_that) {
case _MesCalendario() when $default != null:
return $default(_that.mes,_that.semanas,_that.puedeAvanzar);case _:
  return null;

}
}

}

/// @nodoc


class _MesCalendario implements MesCalendario {
  const _MesCalendario({required this.mes, required  List<List<CeldaDia?>> semanas, required this.puedeAvanzar}): _semanas = semanas;
  

/// Primer día del mes.
@override final  DateTime mes;
/// Semanas de lunes a domingo, 7 celdas cada una. `null` es un hueco de
/// relleno (días del mes anterior o del siguiente).
 final  List<List<CeldaDia?>> _semanas;
/// Semanas de lunes a domingo, 7 celdas cada una. `null` es un hueco de
/// relleno (días del mes anterior o del siguiente).
@override List<List<CeldaDia?>> get semanas {
  if (_semanas is EqualUnmodifiableListView) return _semanas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_semanas);
}

/// Si se puede pasar al mes siguiente: falso en el mes de hoy (RF-3).
@override final  bool puedeAvanzar;

/// Create a copy of MesCalendario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesCalendarioCopyWith<_MesCalendario> get copyWith => __$MesCalendarioCopyWithImpl<_MesCalendario>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesCalendario&&(identical(other.mes, mes) || other.mes == mes)&&const DeepCollectionEquality().equals(other.semanas, _semanas)&&(identical(other.puedeAvanzar, puedeAvanzar) || other.puedeAvanzar == puedeAvanzar));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mes,const DeepCollectionEquality().hash(_semanas),puedeAvanzar);
}

@override
String toString() {
    return 'MesCalendario(mes: $mes, semanas: $semanas, puedeAvanzar: $puedeAvanzar)';
}


}

/// @nodoc
abstract mixin class _$MesCalendarioCopyWith<$Res> implements $MesCalendarioCopyWith<$Res> {
  factory _$MesCalendarioCopyWith(_MesCalendario value, $Res Function(_MesCalendario) _then) = __$MesCalendarioCopyWithImpl;
@override @useResult
$Res call({
 DateTime mes, List<List<CeldaDia?>> semanas, bool puedeAvanzar
});




}
/// @nodoc
class __$MesCalendarioCopyWithImpl<$Res>
    implements _$MesCalendarioCopyWith<$Res> {
  __$MesCalendarioCopyWithImpl(this._self, this._then);

  final _MesCalendario _self;
  final $Res Function(_MesCalendario) _then;

/// Create a copy of MesCalendario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mes = null,Object? semanas = null,Object? puedeAvanzar = null,}) {
  return _then(_MesCalendario(
mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as DateTime,semanas: null == semanas ? _self._semanas : semanas // ignore: cast_nullable_to_non_nullable
as List<List<CeldaDia?>>,puedeAvanzar: null == puedeAvanzar ? _self.puedeAvanzar : puedeAvanzar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CeldaDia {

/// Día local (sin hora).
 DateTime get dia;/// Tiene al menos una sesión. Nunca es cierto en un día futuro (RF-6).
 bool get entrenado;/// Es el día de hoy (RF-5).
 bool get esHoy;/// Es posterior a hoy (RF-6).
 bool get esFuturo;
/// Create a copy of CeldaDia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CeldaDiaCopyWith<CeldaDia> get copyWith => _$CeldaDiaCopyWithImpl<CeldaDia>(this as CeldaDia, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CeldaDia;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CeldaDia&&(identical(other.dia, _this.dia) || other.dia == _this.dia)&&(identical(other.entrenado, _this.entrenado) || other.entrenado == _this.entrenado)&&(identical(other.esHoy, _this.esHoy) || other.esHoy == _this.esHoy)&&(identical(other.esFuturo, _this.esFuturo) || other.esFuturo == _this.esFuturo));
}


@override
int get hashCode {
  final _this = this as CeldaDia;
  return Object.hash(runtimeType,_this.dia,_this.entrenado,_this.esHoy,_this.esFuturo);
}

@override
String toString() {
  final _this = this as CeldaDia;
  return 'CeldaDia(dia: ${_this.dia}, entrenado: ${_this.entrenado}, esHoy: ${_this.esHoy}, esFuturo: ${_this.esFuturo})';
}


}

/// @nodoc
abstract mixin class $CeldaDiaCopyWith<$Res>  {
  factory $CeldaDiaCopyWith(CeldaDia value, $Res Function(CeldaDia) _then) = _$CeldaDiaCopyWithImpl;
@useResult
$Res call({
 DateTime dia, bool entrenado, bool esHoy, bool esFuturo
});




}
/// @nodoc
class _$CeldaDiaCopyWithImpl<$Res>
    implements $CeldaDiaCopyWith<$Res> {
  _$CeldaDiaCopyWithImpl(this._self, this._then);

  final CeldaDia _self;
  final $Res Function(CeldaDia) _then;

/// Create a copy of CeldaDia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dia = null,Object? entrenado = null,Object? esHoy = null,Object? esFuturo = null,}) {
  return _then(CeldaDia(
dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,entrenado: null == entrenado ? _self.entrenado : entrenado // ignore: cast_nullable_to_non_nullable
as bool,esHoy: null == esHoy ? _self.esHoy : esHoy // ignore: cast_nullable_to_non_nullable
as bool,esFuturo: null == esFuturo ? _self.esFuturo : esFuturo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CeldaDia].
extension CeldaDiaPatterns on CeldaDia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CeldaDia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CeldaDia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CeldaDia value)  $default,){
final _that = this;
switch (_that) {
case _CeldaDia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CeldaDia value)?  $default,){
final _that = this;
switch (_that) {
case _CeldaDia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dia,  bool entrenado,  bool esHoy,  bool esFuturo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CeldaDia() when $default != null:
return $default(_that.dia,_that.entrenado,_that.esHoy,_that.esFuturo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dia,  bool entrenado,  bool esHoy,  bool esFuturo)  $default,) {final _that = this;
switch (_that) {
case _CeldaDia():
return $default(_that.dia,_that.entrenado,_that.esHoy,_that.esFuturo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dia,  bool entrenado,  bool esHoy,  bool esFuturo)?  $default,) {final _that = this;
switch (_that) {
case _CeldaDia() when $default != null:
return $default(_that.dia,_that.entrenado,_that.esHoy,_that.esFuturo);case _:
  return null;

}
}

}

/// @nodoc


class _CeldaDia extends CeldaDia {
  const _CeldaDia({required this.dia, required this.entrenado, required this.esHoy, required this.esFuturo}): super._();
  

/// Día local (sin hora).
@override final  DateTime dia;
/// Tiene al menos una sesión. Nunca es cierto en un día futuro (RF-6).
@override final  bool entrenado;
/// Es el día de hoy (RF-5).
@override final  bool esHoy;
/// Es posterior a hoy (RF-6).
@override final  bool esFuturo;

/// Create a copy of CeldaDia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CeldaDiaCopyWith<_CeldaDia> get copyWith => __$CeldaDiaCopyWithImpl<_CeldaDia>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CeldaDia&&(identical(other.dia, dia) || other.dia == dia)&&(identical(other.entrenado, entrenado) || other.entrenado == entrenado)&&(identical(other.esHoy, esHoy) || other.esHoy == esHoy)&&(identical(other.esFuturo, esFuturo) || other.esFuturo == esFuturo));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dia,entrenado,esHoy,esFuturo);
}

@override
String toString() {
    return 'CeldaDia(dia: $dia, entrenado: $entrenado, esHoy: $esHoy, esFuturo: $esFuturo)';
}


}

/// @nodoc
abstract mixin class _$CeldaDiaCopyWith<$Res> implements $CeldaDiaCopyWith<$Res> {
  factory _$CeldaDiaCopyWith(_CeldaDia value, $Res Function(_CeldaDia) _then) = __$CeldaDiaCopyWithImpl;
@override @useResult
$Res call({
 DateTime dia, bool entrenado, bool esHoy, bool esFuturo
});




}
/// @nodoc
class __$CeldaDiaCopyWithImpl<$Res>
    implements _$CeldaDiaCopyWith<$Res> {
  __$CeldaDiaCopyWithImpl(this._self, this._then);

  final _CeldaDia _self;
  final $Res Function(_CeldaDia) _then;

/// Create a copy of CeldaDia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dia = null,Object? entrenado = null,Object? esHoy = null,Object? esFuturo = null,}) {
  return _then(_CeldaDia(
dia: null == dia ? _self.dia : dia // ignore: cast_nullable_to_non_nullable
as DateTime,entrenado: null == entrenado ? _self.entrenado : entrenado // ignore: cast_nullable_to_non_nullable
as bool,esHoy: null == esHoy ? _self.esHoy : esHoy // ignore: cast_nullable_to_non_nullable
as bool,esFuturo: null == esFuturo ? _self.esFuturo : esFuturo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
