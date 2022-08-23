// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SignInDto dto) signIn,
    required TResult Function(SignUpDto dto) signUp,
    required TResult Function(CreateUserDto dto) createUser,
    required TResult Function(User firebaseUser) setCurrentUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSignInEvent value) signIn,
    required TResult Function(AuthSignUpEvent value) signUp,
    required TResult Function(AuthCreateUserEvent value) createUser,
    required TResult Function(AuthSetCurrentUserEvent value) setCurrentUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  final AuthEvent _value;
  // ignore: unused_field
  final $Res Function(AuthEvent) _then;
}

/// @nodoc
abstract class _$$AuthSignInEventCopyWith<$Res> {
  factory _$$AuthSignInEventCopyWith(
          _$AuthSignInEvent value, $Res Function(_$AuthSignInEvent) then) =
      __$$AuthSignInEventCopyWithImpl<$Res>;
  $Res call({SignInDto dto});
}

/// @nodoc
class __$$AuthSignInEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$AuthSignInEventCopyWith<$Res> {
  __$$AuthSignInEventCopyWithImpl(
      _$AuthSignInEvent _value, $Res Function(_$AuthSignInEvent) _then)
      : super(_value, (v) => _then(v as _$AuthSignInEvent));

  @override
  _$AuthSignInEvent get _value => super._value as _$AuthSignInEvent;

  @override
  $Res call({
    Object? dto = freezed,
  }) {
    return _then(_$AuthSignInEvent(
      dto: dto == freezed
          ? _value.dto
          : dto // ignore: cast_nullable_to_non_nullable
              as SignInDto,
    ));
  }
}

/// @nodoc

class _$AuthSignInEvent implements AuthSignInEvent {
  const _$AuthSignInEvent({required this.dto});

  @override
  final SignInDto dto;

  @override
  String toString() {
    return 'AuthEvent.signIn(dto: $dto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSignInEvent &&
            const DeepCollectionEquality().equals(other.dto, dto));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dto));

  @JsonKey(ignore: true)
  @override
  _$$AuthSignInEventCopyWith<_$AuthSignInEvent> get copyWith =>
      __$$AuthSignInEventCopyWithImpl<_$AuthSignInEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SignInDto dto) signIn,
    required TResult Function(SignUpDto dto) signUp,
    required TResult Function(CreateUserDto dto) createUser,
    required TResult Function(User firebaseUser) setCurrentUser,
  }) {
    return signIn(dto);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
  }) {
    return signIn?.call(dto);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (signIn != null) {
      return signIn(dto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSignInEvent value) signIn,
    required TResult Function(AuthSignUpEvent value) signUp,
    required TResult Function(AuthCreateUserEvent value) createUser,
    required TResult Function(AuthSetCurrentUserEvent value) setCurrentUser,
  }) {
    return signIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
  }) {
    return signIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (signIn != null) {
      return signIn(this);
    }
    return orElse();
  }
}

abstract class AuthSignInEvent implements AuthEvent {
  const factory AuthSignInEvent({required final SignInDto dto}) =
      _$AuthSignInEvent;

  SignInDto get dto;
  @JsonKey(ignore: true)
  _$$AuthSignInEventCopyWith<_$AuthSignInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSignUpEventCopyWith<$Res> {
  factory _$$AuthSignUpEventCopyWith(
          _$AuthSignUpEvent value, $Res Function(_$AuthSignUpEvent) then) =
      __$$AuthSignUpEventCopyWithImpl<$Res>;
  $Res call({SignUpDto dto});
}

/// @nodoc
class __$$AuthSignUpEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$AuthSignUpEventCopyWith<$Res> {
  __$$AuthSignUpEventCopyWithImpl(
      _$AuthSignUpEvent _value, $Res Function(_$AuthSignUpEvent) _then)
      : super(_value, (v) => _then(v as _$AuthSignUpEvent));

  @override
  _$AuthSignUpEvent get _value => super._value as _$AuthSignUpEvent;

  @override
  $Res call({
    Object? dto = freezed,
  }) {
    return _then(_$AuthSignUpEvent(
      dto: dto == freezed
          ? _value.dto
          : dto // ignore: cast_nullable_to_non_nullable
              as SignUpDto,
    ));
  }
}

/// @nodoc

class _$AuthSignUpEvent implements AuthSignUpEvent {
  const _$AuthSignUpEvent({required this.dto});

  @override
  final SignUpDto dto;

  @override
  String toString() {
    return 'AuthEvent.signUp(dto: $dto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSignUpEvent &&
            const DeepCollectionEquality().equals(other.dto, dto));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dto));

  @JsonKey(ignore: true)
  @override
  _$$AuthSignUpEventCopyWith<_$AuthSignUpEvent> get copyWith =>
      __$$AuthSignUpEventCopyWithImpl<_$AuthSignUpEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SignInDto dto) signIn,
    required TResult Function(SignUpDto dto) signUp,
    required TResult Function(CreateUserDto dto) createUser,
    required TResult Function(User firebaseUser) setCurrentUser,
  }) {
    return signUp(dto);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
  }) {
    return signUp?.call(dto);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(dto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSignInEvent value) signIn,
    required TResult Function(AuthSignUpEvent value) signUp,
    required TResult Function(AuthCreateUserEvent value) createUser,
    required TResult Function(AuthSetCurrentUserEvent value) setCurrentUser,
  }) {
    return signUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
  }) {
    return signUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(this);
    }
    return orElse();
  }
}

abstract class AuthSignUpEvent implements AuthEvent {
  const factory AuthSignUpEvent({required final SignUpDto dto}) =
      _$AuthSignUpEvent;

  SignUpDto get dto;
  @JsonKey(ignore: true)
  _$$AuthSignUpEventCopyWith<_$AuthSignUpEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthCreateUserEventCopyWith<$Res> {
  factory _$$AuthCreateUserEventCopyWith(_$AuthCreateUserEvent value,
          $Res Function(_$AuthCreateUserEvent) then) =
      __$$AuthCreateUserEventCopyWithImpl<$Res>;
  $Res call({CreateUserDto dto});
}

/// @nodoc
class __$$AuthCreateUserEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$AuthCreateUserEventCopyWith<$Res> {
  __$$AuthCreateUserEventCopyWithImpl(
      _$AuthCreateUserEvent _value, $Res Function(_$AuthCreateUserEvent) _then)
      : super(_value, (v) => _then(v as _$AuthCreateUserEvent));

  @override
  _$AuthCreateUserEvent get _value => super._value as _$AuthCreateUserEvent;

  @override
  $Res call({
    Object? dto = freezed,
  }) {
    return _then(_$AuthCreateUserEvent(
      dto: dto == freezed
          ? _value.dto
          : dto // ignore: cast_nullable_to_non_nullable
              as CreateUserDto,
    ));
  }
}

/// @nodoc

class _$AuthCreateUserEvent implements AuthCreateUserEvent {
  const _$AuthCreateUserEvent({required this.dto});

  @override
  final CreateUserDto dto;

  @override
  String toString() {
    return 'AuthEvent.createUser(dto: $dto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCreateUserEvent &&
            const DeepCollectionEquality().equals(other.dto, dto));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dto));

  @JsonKey(ignore: true)
  @override
  _$$AuthCreateUserEventCopyWith<_$AuthCreateUserEvent> get copyWith =>
      __$$AuthCreateUserEventCopyWithImpl<_$AuthCreateUserEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SignInDto dto) signIn,
    required TResult Function(SignUpDto dto) signUp,
    required TResult Function(CreateUserDto dto) createUser,
    required TResult Function(User firebaseUser) setCurrentUser,
  }) {
    return createUser(dto);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
  }) {
    return createUser?.call(dto);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (createUser != null) {
      return createUser(dto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSignInEvent value) signIn,
    required TResult Function(AuthSignUpEvent value) signUp,
    required TResult Function(AuthCreateUserEvent value) createUser,
    required TResult Function(AuthSetCurrentUserEvent value) setCurrentUser,
  }) {
    return createUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
  }) {
    return createUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (createUser != null) {
      return createUser(this);
    }
    return orElse();
  }
}

abstract class AuthCreateUserEvent implements AuthEvent {
  const factory AuthCreateUserEvent({required final CreateUserDto dto}) =
      _$AuthCreateUserEvent;

  CreateUserDto get dto;
  @JsonKey(ignore: true)
  _$$AuthCreateUserEventCopyWith<_$AuthCreateUserEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSetCurrentUserEventCopyWith<$Res> {
  factory _$$AuthSetCurrentUserEventCopyWith(_$AuthSetCurrentUserEvent value,
          $Res Function(_$AuthSetCurrentUserEvent) then) =
      __$$AuthSetCurrentUserEventCopyWithImpl<$Res>;
  $Res call({User firebaseUser});
}

/// @nodoc
class __$$AuthSetCurrentUserEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$AuthSetCurrentUserEventCopyWith<$Res> {
  __$$AuthSetCurrentUserEventCopyWithImpl(_$AuthSetCurrentUserEvent _value,
      $Res Function(_$AuthSetCurrentUserEvent) _then)
      : super(_value, (v) => _then(v as _$AuthSetCurrentUserEvent));

  @override
  _$AuthSetCurrentUserEvent get _value =>
      super._value as _$AuthSetCurrentUserEvent;

  @override
  $Res call({
    Object? firebaseUser = freezed,
  }) {
    return _then(_$AuthSetCurrentUserEvent(
      firebaseUser: firebaseUser == freezed
          ? _value.firebaseUser
          : firebaseUser // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$AuthSetCurrentUserEvent implements AuthSetCurrentUserEvent {
  const _$AuthSetCurrentUserEvent({required this.firebaseUser});

  @override
  final User firebaseUser;

  @override
  String toString() {
    return 'AuthEvent.setCurrentUser(firebaseUser: $firebaseUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSetCurrentUserEvent &&
            const DeepCollectionEquality()
                .equals(other.firebaseUser, firebaseUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(firebaseUser));

  @JsonKey(ignore: true)
  @override
  _$$AuthSetCurrentUserEventCopyWith<_$AuthSetCurrentUserEvent> get copyWith =>
      __$$AuthSetCurrentUserEventCopyWithImpl<_$AuthSetCurrentUserEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SignInDto dto) signIn,
    required TResult Function(SignUpDto dto) signUp,
    required TResult Function(CreateUserDto dto) createUser,
    required TResult Function(User firebaseUser) setCurrentUser,
  }) {
    return setCurrentUser(firebaseUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
  }) {
    return setCurrentUser?.call(firebaseUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SignInDto dto)? signIn,
    TResult Function(SignUpDto dto)? signUp,
    TResult Function(CreateUserDto dto)? createUser,
    TResult Function(User firebaseUser)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (setCurrentUser != null) {
      return setCurrentUser(firebaseUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSignInEvent value) signIn,
    required TResult Function(AuthSignUpEvent value) signUp,
    required TResult Function(AuthCreateUserEvent value) createUser,
    required TResult Function(AuthSetCurrentUserEvent value) setCurrentUser,
  }) {
    return setCurrentUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
  }) {
    return setCurrentUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSignInEvent value)? signIn,
    TResult Function(AuthSignUpEvent value)? signUp,
    TResult Function(AuthCreateUserEvent value)? createUser,
    TResult Function(AuthSetCurrentUserEvent value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (setCurrentUser != null) {
      return setCurrentUser(this);
    }
    return orElse();
  }
}

abstract class AuthSetCurrentUserEvent implements AuthEvent {
  const factory AuthSetCurrentUserEvent({required final User firebaseUser}) =
      _$AuthSetCurrentUserEvent;

  User get firebaseUser;
  @JsonKey(ignore: true)
  _$$AuthSetCurrentUserEventCopyWith<_$AuthSetCurrentUserEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AuthException exception) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'AuthState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AuthException exception) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, (v) => _then(v as _$_Loading));

  @override
  _$_Loading get _value => super._value as _$_Loading;
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AuthException exception) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, (v) => _then(v as _$_Success));

  @override
  _$_Success get _value => super._value as _$_Success;
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success();

  @override
  String toString() {
    return 'AuthState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AuthException exception) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements AuthState {
  const factory _Success() = _$_Success;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({AuthException exception});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, (v) => _then(v as _$_Error));

  @override
  _$_Error get _value => super._value as _$_Error;

  @override
  $Res call({
    Object? exception = freezed,
  }) {
    return _then(_$_Error(
      exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AuthException,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.exception);

  @override
  final AuthException exception;

  @override
  String toString() {
    return 'AuthState.error(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AuthException exception) error,
  }) {
    return error(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
  }) {
    return error?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AuthException exception)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error(final AuthException exception) = _$_Error;

  AuthException get exception;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
