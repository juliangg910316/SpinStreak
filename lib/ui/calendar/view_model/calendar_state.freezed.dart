// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {

 CalendarStatus get status;/// Día de hoy según el reloj del Cubit en la última carga.
 DateTime? get hoy;/// Primer día del mes que se muestra.
 DateTime? get mesVisible;/// Días con sesiones, por día local.
 Map<DateTime, DiaHistorial> get dias;/// Cuadrícula del mes visible, de `construirMes`.
 MesCalendario? get mes;/// Día seleccionado (RF-7), o `null` si no hay ninguno.
 DateTime? get seleccionado;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.hoy, _this.hoy) || other.hoy == _this.hoy)&&(identical(other.mesVisible, _this.mesVisible) || other.mesVisible == _this.mesVisible)&&const DeepCollectionEquality().equals(other.dias, _this.dias)&&(identical(other.mes, _this.mes) || other.mes == _this.mes)&&(identical(other.seleccionado, _this.seleccionado) || other.seleccionado == _this.seleccionado));
}


@override
int get hashCode {
  final _this = this as CalendarState;
  return Object.hash(runtimeType,_this.status,_this.hoy,_this.mesVisible,const DeepCollectionEquality().hash(_this.dias),_this.mes,_this.seleccionado);
}

@override
String toString() {
  final _this = this as CalendarState;
  return 'CalendarState(status: ${_this.status}, hoy: ${_this.hoy}, mesVisible: ${_this.mesVisible}, dias: ${_this.dias}, mes: ${_this.mes}, seleccionado: ${_this.seleccionado})';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 CalendarStatus status, DateTime? hoy, DateTime? mesVisible, Map<DateTime, DiaHistorial> dias, MesCalendario? mes, DateTime? seleccionado
});


$MesCalendarioCopyWith<$Res>? get mes;

}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? hoy = freezed,Object? mesVisible = freezed,Object? dias = null,Object? mes = freezed,Object? seleccionado = freezed,}) {
  return _then(CalendarState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CalendarStatus,hoy: freezed == hoy ? _self.hoy : hoy // ignore: cast_nullable_to_non_nullable
as DateTime?,mesVisible: freezed == mesVisible ? _self.mesVisible : mesVisible // ignore: cast_nullable_to_non_nullable
as DateTime?,dias: null == dias ? _self.dias : dias // ignore: cast_nullable_to_non_nullable
as Map<DateTime, DiaHistorial>,mes: freezed == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as MesCalendario?,seleccionado: freezed == seleccionado ? _self.seleccionado : seleccionado // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MesCalendarioCopyWith<$Res>? get mes {
    if (_self.mes == null) {
    return null;
  }

  return $MesCalendarioCopyWith<$Res>(_self.mes!, (value) {
    return _then(_self.copyWith(mes: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarStatus status,  DateTime? hoy,  DateTime? mesVisible,  Map<DateTime, DiaHistorial> dias,  MesCalendario? mes,  DateTime? seleccionado)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.status,_that.hoy,_that.mesVisible,_that.dias,_that.mes,_that.seleccionado);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarStatus status,  DateTime? hoy,  DateTime? mesVisible,  Map<DateTime, DiaHistorial> dias,  MesCalendario? mes,  DateTime? seleccionado)  $default,) {final _that = this;
switch (_that) {
case _CalendarState():
return $default(_that.status,_that.hoy,_that.mesVisible,_that.dias,_that.mes,_that.seleccionado);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarStatus status,  DateTime? hoy,  DateTime? mesVisible,  Map<DateTime, DiaHistorial> dias,  MesCalendario? mes,  DateTime? seleccionado)?  $default,) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.status,_that.hoy,_that.mesVisible,_that.dias,_that.mes,_that.seleccionado);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarState extends CalendarState {
  const _CalendarState({this.status = CalendarStatus.loading, this.hoy, this.mesVisible,  Map<DateTime, DiaHistorial> dias = const {}, this.mes, this.seleccionado}): _dias = dias,super._();
  

@override@JsonKey() final  CalendarStatus status;
/// Día de hoy según el reloj del Cubit en la última carga.
@override final  DateTime? hoy;
/// Primer día del mes que se muestra.
@override final  DateTime? mesVisible;
/// Días con sesiones, por día local.
 final  Map<DateTime, DiaHistorial> _dias;
/// Días con sesiones, por día local.
@override@JsonKey() Map<DateTime, DiaHistorial> get dias {
  if (_dias is EqualUnmodifiableMapView) return _dias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dias);
}

/// Cuadrícula del mes visible, de `construirMes`.
@override final  MesCalendario? mes;
/// Día seleccionado (RF-7), o `null` si no hay ninguno.
@override final  DateTime? seleccionado;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.status, status) || other.status == status)&&(identical(other.hoy, hoy) || other.hoy == hoy)&&(identical(other.mesVisible, mesVisible) || other.mesVisible == mesVisible)&&const DeepCollectionEquality().equals(other.dias, _dias)&&(identical(other.mes, mes) || other.mes == mes)&&(identical(other.seleccionado, seleccionado) || other.seleccionado == seleccionado));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,hoy,mesVisible,const DeepCollectionEquality().hash(_dias),mes,seleccionado);
}

@override
String toString() {
    return 'CalendarState(status: $status, hoy: $hoy, mesVisible: $mesVisible, dias: $dias, mes: $mes, seleccionado: $seleccionado)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 CalendarStatus status, DateTime? hoy, DateTime? mesVisible, Map<DateTime, DiaHistorial> dias, MesCalendario? mes, DateTime? seleccionado
});


@override $MesCalendarioCopyWith<$Res>? get mes;

}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? hoy = freezed,Object? mesVisible = freezed,Object? dias = null,Object? mes = freezed,Object? seleccionado = freezed,}) {
  return _then(_CalendarState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CalendarStatus,hoy: freezed == hoy ? _self.hoy : hoy // ignore: cast_nullable_to_non_nullable
as DateTime?,mesVisible: freezed == mesVisible ? _self.mesVisible : mesVisible // ignore: cast_nullable_to_non_nullable
as DateTime?,dias: null == dias ? _self._dias : dias // ignore: cast_nullable_to_non_nullable
as Map<DateTime, DiaHistorial>,mes: freezed == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as MesCalendario?,seleccionado: freezed == seleccionado ? _self.seleccionado : seleccionado // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MesCalendarioCopyWith<$Res>? get mes {
    if (_self.mes == null) {
    return null;
  }

  return $MesCalendarioCopyWith<$Res>(_self.mes!, (value) {
    return _then(_self.copyWith(mes: value));
  });
}
}

// dart format on
