// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionFormState {

 ModoFormulario get modo;/// Sesión que se edita; `null` al registrar una nueva.
 Session? get original; EntradaSesion get entrada;/// Valores al abrir el formulario, para saber si hay cambios (RF-16).
 EntradaSesion get entradaInicial;/// Errores de validación por campo (RF-3, RF-4).
 Map<CampoSesion, ErrorCampo> get errores; SessionFormStatus get status;/// Solo con `status == error`.
 OperacionFallida? get fallo;/// Récords que bate la sesión registrada (spec 004, RF-10). Vacío al
/// editar.
 List<TipoRecord> get recordsBatidos;
/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionFormStateCopyWith<SessionFormState> get copyWith => _$SessionFormStateCopyWithImpl<SessionFormState>(this as SessionFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionFormState&&(identical(other.modo, _this.modo) || other.modo == _this.modo)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.entrada, _this.entrada) || other.entrada == _this.entrada)&&(identical(other.entradaInicial, _this.entradaInicial) || other.entradaInicial == _this.entradaInicial)&&const DeepCollectionEquality().equals(other.errores, _this.errores)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.fallo, _this.fallo) || other.fallo == _this.fallo)&&const DeepCollectionEquality().equals(other.recordsBatidos, _this.recordsBatidos));
}


@override
int get hashCode {
  final _this = this as SessionFormState;
  return Object.hash(runtimeType,_this.modo,_this.original,_this.entrada,_this.entradaInicial,const DeepCollectionEquality().hash(_this.errores),_this.status,_this.fallo,const DeepCollectionEquality().hash(_this.recordsBatidos));
}

@override
String toString() {
  final _this = this as SessionFormState;
  return 'SessionFormState(modo: ${_this.modo}, original: ${_this.original}, entrada: ${_this.entrada}, entradaInicial: ${_this.entradaInicial}, errores: ${_this.errores}, status: ${_this.status}, fallo: ${_this.fallo}, recordsBatidos: ${_this.recordsBatidos})';
}


}

/// @nodoc
abstract mixin class $SessionFormStateCopyWith<$Res>  {
  factory $SessionFormStateCopyWith(SessionFormState value, $Res Function(SessionFormState) _then) = _$SessionFormStateCopyWithImpl;
@useResult
$Res call({
 ModoFormulario modo, Session? original, EntradaSesion entrada, EntradaSesion entradaInicial, Map<CampoSesion, ErrorCampo> errores, SessionFormStatus status, OperacionFallida? fallo, List<TipoRecord> recordsBatidos
});


$SessionCopyWith<$Res>? get original;$EntradaSesionCopyWith<$Res> get entrada;$EntradaSesionCopyWith<$Res> get entradaInicial;

}
/// @nodoc
class _$SessionFormStateCopyWithImpl<$Res>
    implements $SessionFormStateCopyWith<$Res> {
  _$SessionFormStateCopyWithImpl(this._self, this._then);

  final SessionFormState _self;
  final $Res Function(SessionFormState) _then;

/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modo = null,Object? original = freezed,Object? entrada = null,Object? entradaInicial = null,Object? errores = null,Object? status = null,Object? fallo = freezed,Object? recordsBatidos = null,}) {
  return _then(SessionFormState(
modo: null == modo ? _self.modo : modo // ignore: cast_nullable_to_non_nullable
as ModoFormulario,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Session?,entrada: null == entrada ? _self.entrada : entrada // ignore: cast_nullable_to_non_nullable
as EntradaSesion,entradaInicial: null == entradaInicial ? _self.entradaInicial : entradaInicial // ignore: cast_nullable_to_non_nullable
as EntradaSesion,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as Map<CampoSesion, ErrorCampo>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionFormStatus,fallo: freezed == fallo ? _self.fallo : fallo // ignore: cast_nullable_to_non_nullable
as OperacionFallida?,recordsBatidos: null == recordsBatidos ? _self.recordsBatidos : recordsBatidos // ignore: cast_nullable_to_non_nullable
as List<TipoRecord>,
  ));
}
/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaSesionCopyWith<$Res> get entrada {
  
  return $EntradaSesionCopyWith<$Res>(_self.entrada, (value) {
    return _then(_self.copyWith(entrada: value));
  });
}/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaSesionCopyWith<$Res> get entradaInicial {
  
  return $EntradaSesionCopyWith<$Res>(_self.entradaInicial, (value) {
    return _then(_self.copyWith(entradaInicial: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionFormState].
extension SessionFormStatePatterns on SessionFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionFormState value)  $default,){
final _that = this;
switch (_that) {
case _SessionFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ModoFormulario modo,  Session? original,  EntradaSesion entrada,  EntradaSesion entradaInicial,  Map<CampoSesion, ErrorCampo> errores,  SessionFormStatus status,  OperacionFallida? fallo,  List<TipoRecord> recordsBatidos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionFormState() when $default != null:
return $default(_that.modo,_that.original,_that.entrada,_that.entradaInicial,_that.errores,_that.status,_that.fallo,_that.recordsBatidos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ModoFormulario modo,  Session? original,  EntradaSesion entrada,  EntradaSesion entradaInicial,  Map<CampoSesion, ErrorCampo> errores,  SessionFormStatus status,  OperacionFallida? fallo,  List<TipoRecord> recordsBatidos)  $default,) {final _that = this;
switch (_that) {
case _SessionFormState():
return $default(_that.modo,_that.original,_that.entrada,_that.entradaInicial,_that.errores,_that.status,_that.fallo,_that.recordsBatidos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ModoFormulario modo,  Session? original,  EntradaSesion entrada,  EntradaSesion entradaInicial,  Map<CampoSesion, ErrorCampo> errores,  SessionFormStatus status,  OperacionFallida? fallo,  List<TipoRecord> recordsBatidos)?  $default,) {final _that = this;
switch (_that) {
case _SessionFormState() when $default != null:
return $default(_that.modo,_that.original,_that.entrada,_that.entradaInicial,_that.errores,_that.status,_that.fallo,_that.recordsBatidos);case _:
  return null;

}
}

}

/// @nodoc


class _SessionFormState extends SessionFormState {
  const _SessionFormState({this.modo = ModoFormulario.nuevo, this.original, this.entrada = const EntradaSesion(), this.entradaInicial = const EntradaSesion(),  Map<CampoSesion, ErrorCampo> errores = const {}, this.status = SessionFormStatus.editando, this.fallo,  List<TipoRecord> recordsBatidos = const []}): _errores = errores,_recordsBatidos = recordsBatidos,super._();
  

@override@JsonKey() final  ModoFormulario modo;
/// Sesión que se edita; `null` al registrar una nueva.
@override final  Session? original;
@override@JsonKey() final  EntradaSesion entrada;
/// Valores al abrir el formulario, para saber si hay cambios (RF-16).
@override@JsonKey() final  EntradaSesion entradaInicial;
/// Errores de validación por campo (RF-3, RF-4).
 final  Map<CampoSesion, ErrorCampo> _errores;
/// Errores de validación por campo (RF-3, RF-4).
@override@JsonKey() Map<CampoSesion, ErrorCampo> get errores {
  if (_errores is EqualUnmodifiableMapView) return _errores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errores);
}

@override@JsonKey() final  SessionFormStatus status;
/// Solo con `status == error`.
@override final  OperacionFallida? fallo;
/// Récords que bate la sesión registrada (spec 004, RF-10). Vacío al
/// editar.
 final  List<TipoRecord> _recordsBatidos;
/// Récords que bate la sesión registrada (spec 004, RF-10). Vacío al
/// editar.
@override@JsonKey() List<TipoRecord> get recordsBatidos {
  if (_recordsBatidos is EqualUnmodifiableListView) return _recordsBatidos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recordsBatidos);
}


/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionFormStateCopyWith<_SessionFormState> get copyWith => __$SessionFormStateCopyWithImpl<_SessionFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionFormState&&(identical(other.modo, modo) || other.modo == modo)&&(identical(other.original, original) || other.original == original)&&(identical(other.entrada, entrada) || other.entrada == entrada)&&(identical(other.entradaInicial, entradaInicial) || other.entradaInicial == entradaInicial)&&const DeepCollectionEquality().equals(other.errores, _errores)&&(identical(other.status, status) || other.status == status)&&(identical(other.fallo, fallo) || other.fallo == fallo)&&const DeepCollectionEquality().equals(other.recordsBatidos, _recordsBatidos));
}


@override
int get hashCode {
    return Object.hash(runtimeType,modo,original,entrada,entradaInicial,const DeepCollectionEquality().hash(_errores),status,fallo,const DeepCollectionEquality().hash(_recordsBatidos));
}

@override
String toString() {
    return 'SessionFormState(modo: $modo, original: $original, entrada: $entrada, entradaInicial: $entradaInicial, errores: $errores, status: $status, fallo: $fallo, recordsBatidos: $recordsBatidos)';
}


}

/// @nodoc
abstract mixin class _$SessionFormStateCopyWith<$Res> implements $SessionFormStateCopyWith<$Res> {
  factory _$SessionFormStateCopyWith(_SessionFormState value, $Res Function(_SessionFormState) _then) = __$SessionFormStateCopyWithImpl;
@override @useResult
$Res call({
 ModoFormulario modo, Session? original, EntradaSesion entrada, EntradaSesion entradaInicial, Map<CampoSesion, ErrorCampo> errores, SessionFormStatus status, OperacionFallida? fallo, List<TipoRecord> recordsBatidos
});


@override $SessionCopyWith<$Res>? get original;@override $EntradaSesionCopyWith<$Res> get entrada;@override $EntradaSesionCopyWith<$Res> get entradaInicial;

}
/// @nodoc
class __$SessionFormStateCopyWithImpl<$Res>
    implements _$SessionFormStateCopyWith<$Res> {
  __$SessionFormStateCopyWithImpl(this._self, this._then);

  final _SessionFormState _self;
  final $Res Function(_SessionFormState) _then;

/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modo = null,Object? original = freezed,Object? entrada = null,Object? entradaInicial = null,Object? errores = null,Object? status = null,Object? fallo = freezed,Object? recordsBatidos = null,}) {
  return _then(_SessionFormState(
modo: null == modo ? _self.modo : modo // ignore: cast_nullable_to_non_nullable
as ModoFormulario,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Session?,entrada: null == entrada ? _self.entrada : entrada // ignore: cast_nullable_to_non_nullable
as EntradaSesion,entradaInicial: null == entradaInicial ? _self.entradaInicial : entradaInicial // ignore: cast_nullable_to_non_nullable
as EntradaSesion,errores: null == errores ? _self._errores : errores // ignore: cast_nullable_to_non_nullable
as Map<CampoSesion, ErrorCampo>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionFormStatus,fallo: freezed == fallo ? _self.fallo : fallo // ignore: cast_nullable_to_non_nullable
as OperacionFallida?,recordsBatidos: null == recordsBatidos ? _self._recordsBatidos : recordsBatidos // ignore: cast_nullable_to_non_nullable
as List<TipoRecord>,
  ));
}

/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaSesionCopyWith<$Res> get entrada {
  
  return $EntradaSesionCopyWith<$Res>(_self.entrada, (value) {
    return _then(_self.copyWith(entrada: value));
  });
}/// Create a copy of SessionFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaSesionCopyWith<$Res> get entradaInicial {
  
  return $EntradaSesionCopyWith<$Res>(_self.entradaInicial, (value) {
    return _then(_self.copyWith(entradaInicial: value));
  });
}
}

/// @nodoc
mixin _$ResultadoFormulario {

 SessionFormStatus get status; List<TipoRecord> get recordsBatidos;
/// Create a copy of ResultadoFormulario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultadoFormularioCopyWith<ResultadoFormulario> get copyWith => _$ResultadoFormularioCopyWithImpl<ResultadoFormulario>(this as ResultadoFormulario, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResultadoFormulario;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultadoFormulario&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.recordsBatidos, _this.recordsBatidos));
}


@override
int get hashCode {
  final _this = this as ResultadoFormulario;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.recordsBatidos));
}

@override
String toString() {
  final _this = this as ResultadoFormulario;
  return 'ResultadoFormulario(status: ${_this.status}, recordsBatidos: ${_this.recordsBatidos})';
}


}

/// @nodoc
abstract mixin class $ResultadoFormularioCopyWith<$Res>  {
  factory $ResultadoFormularioCopyWith(ResultadoFormulario value, $Res Function(ResultadoFormulario) _then) = _$ResultadoFormularioCopyWithImpl;
@useResult
$Res call({
 SessionFormStatus status, List<TipoRecord> recordsBatidos
});




}
/// @nodoc
class _$ResultadoFormularioCopyWithImpl<$Res>
    implements $ResultadoFormularioCopyWith<$Res> {
  _$ResultadoFormularioCopyWithImpl(this._self, this._then);

  final ResultadoFormulario _self;
  final $Res Function(ResultadoFormulario) _then;

/// Create a copy of ResultadoFormulario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? recordsBatidos = null,}) {
  return _then(ResultadoFormulario(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionFormStatus,recordsBatidos: null == recordsBatidos ? _self.recordsBatidos : recordsBatidos // ignore: cast_nullable_to_non_nullable
as List<TipoRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResultadoFormulario].
extension ResultadoFormularioPatterns on ResultadoFormulario {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultadoFormulario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultadoFormulario() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultadoFormulario value)  $default,){
final _that = this;
switch (_that) {
case _ResultadoFormulario():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultadoFormulario value)?  $default,){
final _that = this;
switch (_that) {
case _ResultadoFormulario() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SessionFormStatus status,  List<TipoRecord> recordsBatidos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultadoFormulario() when $default != null:
return $default(_that.status,_that.recordsBatidos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SessionFormStatus status,  List<TipoRecord> recordsBatidos)  $default,) {final _that = this;
switch (_that) {
case _ResultadoFormulario():
return $default(_that.status,_that.recordsBatidos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SessionFormStatus status,  List<TipoRecord> recordsBatidos)?  $default,) {final _that = this;
switch (_that) {
case _ResultadoFormulario() when $default != null:
return $default(_that.status,_that.recordsBatidos);case _:
  return null;

}
}

}

/// @nodoc


class _ResultadoFormulario implements ResultadoFormulario {
  const _ResultadoFormulario({required this.status,  List<TipoRecord> recordsBatidos = const []}): _recordsBatidos = recordsBatidos;
  

@override final  SessionFormStatus status;
 final  List<TipoRecord> _recordsBatidos;
@override@JsonKey() List<TipoRecord> get recordsBatidos {
  if (_recordsBatidos is EqualUnmodifiableListView) return _recordsBatidos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recordsBatidos);
}


/// Create a copy of ResultadoFormulario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultadoFormularioCopyWith<_ResultadoFormulario> get copyWith => __$ResultadoFormularioCopyWithImpl<_ResultadoFormulario>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultadoFormulario&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.recordsBatidos, _recordsBatidos));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_recordsBatidos));
}

@override
String toString() {
    return 'ResultadoFormulario(status: $status, recordsBatidos: $recordsBatidos)';
}


}

/// @nodoc
abstract mixin class _$ResultadoFormularioCopyWith<$Res> implements $ResultadoFormularioCopyWith<$Res> {
  factory _$ResultadoFormularioCopyWith(_ResultadoFormulario value, $Res Function(_ResultadoFormulario) _then) = __$ResultadoFormularioCopyWithImpl;
@override @useResult
$Res call({
 SessionFormStatus status, List<TipoRecord> recordsBatidos
});




}
/// @nodoc
class __$ResultadoFormularioCopyWithImpl<$Res>
    implements _$ResultadoFormularioCopyWith<$Res> {
  __$ResultadoFormularioCopyWithImpl(this._self, this._then);

  final _ResultadoFormulario _self;
  final $Res Function(_ResultadoFormulario) _then;

/// Create a copy of ResultadoFormulario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? recordsBatidos = null,}) {
  return _then(_ResultadoFormulario(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionFormStatus,recordsBatidos: null == recordsBatidos ? _self._recordsBatidos : recordsBatidos // ignore: cast_nullable_to_non_nullable
as List<TipoRecord>,
  ));
}


}

// dart format on
