// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  List<Contact> get participants => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Message? get lastMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res>;
  $Res call(
      {String id,
      List<Contact> participants,
      DateTime updatedAt,
      Message? lastMessage});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  final Conversation _value;
  // ignore: unused_field
  final $Res Function(Conversation) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? participants = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participants: participants == freezed
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }

  @override
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
abstract class _$$_ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$_ConversationCopyWith(
          _$_Conversation value, $Res Function(_$_Conversation) then) =
      __$$_ConversationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      List<Contact> participants,
      DateTime updatedAt,
      Message? lastMessage});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_ConversationCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res>
    implements _$$_ConversationCopyWith<$Res> {
  __$$_ConversationCopyWithImpl(
      _$_Conversation _value, $Res Function(_$_Conversation) _then)
      : super(_value, (v) => _then(v as _$_Conversation));

  @override
  _$_Conversation get _value => super._value as _$_Conversation;

  @override
  $Res call({
    Object? id = freezed,
    Object? participants = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_$_Conversation(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participants: participants == freezed
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Conversation implements _Conversation {
  const _$_Conversation(
      {required this.id,
      required final List<Contact> participants,
      required this.updatedAt,
      this.lastMessage})
      : _participants = participants;

  factory _$_Conversation.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationFromJson(json);

  @override
  final String id;
  final List<Contact> _participants;
  @override
  List<Contact> get participants {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final DateTime updatedAt;
  @override
  final Message? lastMessage;

  @override
  String toString() {
    return 'Conversation(id: $id, participants: $participants, updatedAt: $updatedAt, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conversation &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.lastMessage, lastMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_participants),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(lastMessage));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationCopyWith<_$_Conversation> get copyWith =>
      __$$_ConversationCopyWithImpl<_$_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {required final String id,
      required final List<Contact> participants,
      required final DateTime updatedAt,
      final Message? lastMessage}) = _$_Conversation;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$_Conversation.fromJson;

  @override
  String get id;
  @override
  List<Contact> get participants;
  @override
  DateTime get updatedAt;
  @override
  Message? get lastMessage;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationCopyWith<_$_Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}
