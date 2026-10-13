// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_validator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ErrorCampo {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorCampo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ErrorCampo()';
}


}

/// @nodoc
class $ErrorCampoCopyWith<$Res>  {
$ErrorCampoCopyWith(ErrorCampo _, $Res Function(ErrorCampo) __);
}


/// Adds pattern-matching-related methods to [ErrorCampo].
extension ErrorCampoPatterns on ErrorCampo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Falta value)?  falta,TResult Function( NoNumerico value)?  noNumerico,TResult Function( FueraDeRango value)?  fueraDeRango,TResult Function( DemasiadosDecimales value)?  demasiadosDecimales,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Falta() when falta != null:
return falta(_that);case NoNumerico() when noNumerico != null:
return noNumerico(_that);case FueraDeRango() when fueraDeRango != null:
return fueraDeRango(_that);case DemasiadosDecimales() when demasiadosDecimales != null:
return demasiadosDecimales(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Falta value)  falta,required TResult Function( NoNumerico value)  noNumerico,required TResult Function( FueraDeRango value)  fueraDeRango,required TResult Function( DemasiadosDecimales value)  demasiadosDecimales,}){
final _that = this;
switch (_that) {
case Falta():
return falta(_that);case NoNumerico():
return noNumerico(_that);case FueraDeRango():
return fueraDeRango(_that);case DemasiadosDecimales():
return demasiadosDecimales(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Falta value)?  falta,TResult? Function( NoNumerico value)?  noNumerico,TResult? Function( FueraDeRango value)?  fueraDeRango,TResult? Function( DemasiadosDecimales value)?  demasiadosDecimales,}){
final _that = this;
switch (_that) {
case Falta() when falta != null:
return falta(_that);case NoNumerico() when noNumerico != null:
return noNumerico(_that);case FueraDeRango() when fueraDeRango != null:
return fueraDeRango(_that);case DemasiadosDecimales() when demasiadosDecimales != null:
return demasiadosDecimales(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  falta,TResult Function()?  noNumerico,TResult Function( num min,  num max,  bool minExclusivo)?  fueraDeRango,TResult Function( int max)?  demasiadosDecimales,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Falta() when falta != null:
return falta();case NoNumerico() when noNumerico != null:
return noNumerico();case FueraDeRango() when fueraDeRango != null:
return fueraDeRango(_that.min,_that.max,_that.minExclusivo);case DemasiadosDecimales() when demasiadosDecimales != null:
return demasiadosDecimales(_that.max);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  falta,required TResult Function()  noNumerico,required TResult Function( num min,  num max,  bool minExclusivo)  fueraDeRango,required TResult Function( int max)  demasiadosDecimales,}) {final _that = this;
switch (_that) {
case Falta():
return falta();case NoNumerico():
return noNumerico();case FueraDeRango():
return fueraDeRango(_that.min,_that.max,_that.minExclusivo);case DemasiadosDecimales():
return demasiadosDecimales(_that.max);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  falta,TResult? Function()?  noNumerico,TResult? Function( num min,  num max,  bool minExclusivo)?  fueraDeRango,TResult? Function( int max)?  demasiadosDecimales,}) {final _that = this;
switch (_that) {
case Falta() when falta != null:
return falta();case NoNumerico() when noNumerico != null:
return noNumerico();case FueraDeRango() when fueraDeRango != null:
return fueraDeRango(_that.min,_that.max,_that.minExclusivo);case DemasiadosDecimales() when demasiadosDecimales != null:
return demasiadosDecimales(_that.max);case _:
  return null;

}
}

}

/// @nodoc


class Falta implements ErrorCampo {
  const Falta();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Falta);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ErrorCampo.falta()';
}


}




/// @nodoc


class NoNumerico implements ErrorCampo {
  const NoNumerico();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NoNumerico);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ErrorCampo.noNumerico()';
}


}




/// @nodoc


class FueraDeRango implements ErrorCampo {
  const FueraDeRango({required this.min, required this.max, this.minExclusivo = false});
  

 final  num min;
 final  num max;
@JsonKey() final  bool minExclusivo;

/// Create a copy of ErrorCampo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FueraDeRangoCopyWith<FueraDeRango> get copyWith => _$FueraDeRangoCopyWithImpl<FueraDeRango>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FueraDeRango&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.minExclusivo, minExclusivo) || other.minExclusivo == minExclusivo));
}


@override
int get hashCode {
    return Object.hash(runtimeType,min,max,minExclusivo);
}

@override
String toString() {
    return 'ErrorCampo.fueraDeRango(min: $min, max: $max, minExclusivo: $minExclusivo)';
}


}

/// @nodoc
abstract mixin class $FueraDeRangoCopyWith<$Res> implements $ErrorCampoCopyWith<$Res> {
  factory $FueraDeRangoCopyWith(FueraDeRango value, $Res Function(FueraDeRango) _then) = _$FueraDeRangoCopyWithImpl;
@useResult
$Res call({
 num min, num max, bool minExclusivo
});




}
/// @nodoc
class _$FueraDeRangoCopyWithImpl<$Res>
    implements $FueraDeRangoCopyWith<$Res> {
  _$FueraDeRangoCopyWithImpl(this._self, this._then);

  final FueraDeRango _self;
  final $Res Function(FueraDeRango) _then;

/// Create a copy of ErrorCampo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? min = null,Object? max = null,Object? minExclusivo = null,}) {
  return _then(FueraDeRango(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num,minExclusivo: null == minExclusivo ? _self.minExclusivo : minExclusivo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DemasiadosDecimales implements ErrorCampo {
  const DemasiadosDecimales({required this.max});
  

 final  int max;

/// Create a copy of ErrorCampo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemasiadosDecimalesCopyWith<DemasiadosDecimales> get copyWith => _$DemasiadosDecimalesCopyWithImpl<DemasiadosDecimales>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DemasiadosDecimales&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode {
    return Object.hash(runtimeType,max);
}

@override
String toString() {
    return 'ErrorCampo.demasiadosDecimales(max: $max)';
}


}

/// @nodoc
abstract mixin class $DemasiadosDecimalesCopyWith<$Res> implements $ErrorCampoCopyWith<$Res> {
  factory $DemasiadosDecimalesCopyWith(DemasiadosDecimales value, $Res Function(DemasiadosDecimales) _then) = _$DemasiadosDecimalesCopyWithImpl;
@useResult
$Res call({
 int max
});




}
/// @nodoc
class _$DemasiadosDecimalesCopyWithImpl<$Res>
    implements $DemasiadosDecimalesCopyWith<$Res> {
  _$DemasiadosDecimalesCopyWithImpl(this._self, this._then);

  final DemasiadosDecimales _self;
  final $Res Function(DemasiadosDecimales) _then;

/// Create a copy of ErrorCampo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? max = null,}) {
  return _then(DemasiadosDecimales(
max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ResultadoValidacion {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultadoValidacion);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ResultadoValidacion()';
}


}

/// @nodoc
class $ResultadoValidacionCopyWith<$Res>  {
$ResultadoValidacionCopyWith(ResultadoValidacion _, $Res Function(ResultadoValidacion) __);
}


/// Adds pattern-matching-related methods to [ResultadoValidacion].
extension ResultadoValidacionPatterns on ResultadoValidacion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Valida value)?  valida,TResult Function( Invalida value)?  invalida,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Valida() when valida != null:
return valida(_that);case Invalida() when invalida != null:
return invalida(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Valida value)  valida,required TResult Function( Invalida value)  invalida,}){
final _that = this;
switch (_that) {
case Valida():
return valida(_that);case Invalida():
return invalida(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Valida value)?  valida,TResult? Function( Invalida value)?  invalida,}){
final _that = this;
switch (_that) {
case Valida() when valida != null:
return valida(_that);case Invalida() when invalida != null:
return invalida(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SessionData datos)?  valida,TResult Function( Map<CampoSesion, ErrorCampo> errores)?  invalida,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Valida() when valida != null:
return valida(_that.datos);case Invalida() when invalida != null:
return invalida(_that.errores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SessionData datos)  valida,required TResult Function( Map<CampoSesion, ErrorCampo> errores)  invalida,}) {final _that = this;
switch (_that) {
case Valida():
return valida(_that.datos);case Invalida():
return invalida(_that.errores);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SessionData datos)?  valida,TResult? Function( Map<CampoSesion, ErrorCampo> errores)?  invalida,}) {final _that = this;
switch (_that) {
case Valida() when valida != null:
return valida(_that.datos);case Invalida() when invalida != null:
return invalida(_that.errores);case _:
  return null;

}
}

}

/// @nodoc


class Valida implements ResultadoValidacion {
  const Valida(this.datos);
  

 final  SessionData datos;

/// Create a copy of ResultadoValidacion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidaCopyWith<Valida> get copyWith => _$ValidaCopyWithImpl<Valida>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Valida&&(identical(other.datos, datos) || other.datos == datos));
}


@override
int get hashCode {
    return Object.hash(runtimeType,datos);
}

@override
String toString() {
    return 'ResultadoValidacion.valida(datos: $datos)';
}


}

/// @nodoc
abstract mixin class $ValidaCopyWith<$Res> implements $ResultadoValidacionCopyWith<$Res> {
  factory $ValidaCopyWith(Valida value, $Res Function(Valida) _then) = _$ValidaCopyWithImpl;
@useResult
$Res call({
 SessionData datos
});


$SessionDataCopyWith<$Res> get datos;

}
/// @nodoc
class _$ValidaCopyWithImpl<$Res>
    implements $ValidaCopyWith<$Res> {
  _$ValidaCopyWithImpl(this._self, this._then);

  final Valida _self;
  final $Res Function(Valida) _then;

/// Create a copy of ResultadoValidacion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? datos = null,}) {
  return _then(Valida(
null == datos ? _self.datos : datos // ignore: cast_nullable_to_non_nullable
as SessionData,
  ));
}

/// Create a copy of ResultadoValidacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionDataCopyWith<$Res> get datos {
  
  return $SessionDataCopyWith<$Res>(_self.datos, (value) {
    return _then(_self.copyWith(datos: value));
  });
}
}

/// @nodoc


class Invalida implements ResultadoValidacion {
  const Invalida( Map<CampoSesion, ErrorCampo> errores): _errores = errores;
  

 final  Map<CampoSesion, ErrorCampo> _errores;
 Map<CampoSesion, ErrorCampo> get errores {
  if (_errores is EqualUnmodifiableMapView) return _errores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errores);
}


/// Create a copy of ResultadoValidacion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidaCopyWith<Invalida> get copyWith => _$InvalidaCopyWithImpl<Invalida>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Invalida&&const DeepCollectionEquality().equals(other.errores, _errores));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_errores));
}

@override
String toString() {
    return 'ResultadoValidacion.invalida(errores: $errores)';
}


}

/// @nodoc
abstract mixin class $InvalidaCopyWith<$Res> implements $ResultadoValidacionCopyWith<$Res> {
  factory $InvalidaCopyWith(Invalida value, $Res Function(Invalida) _then) = _$InvalidaCopyWithImpl;
@useResult
$Res call({
 Map<CampoSesion, ErrorCampo> errores
});




}
/// @nodoc
class _$InvalidaCopyWithImpl<$Res>
    implements $InvalidaCopyWith<$Res> {
  _$InvalidaCopyWithImpl(this._self, this._then);

  final Invalida _self;
  final $Res Function(Invalida) _then;

/// Create a copy of ResultadoValidacion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errores = null,}) {
  return _then(Invalida(
null == errores ? _self._errores : errores // ignore: cast_nullable_to_non_nullable
as Map<CampoSesion, ErrorCampo>,
  ));
}


}

// dart format on
