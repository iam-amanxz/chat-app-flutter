// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Conversation _$$_ConversationFromJson(Map<String, dynamic> json) =>
    _$_Conversation(
      id: json['id'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConversationToJson(_$_Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastMessage': instance.lastMessage?.toJson(),
    };
