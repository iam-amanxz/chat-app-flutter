// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Contact _$$_ContactFromJson(Map<String, dynamic> json) => _$_Contact(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String?,
      about: json['about'] as String?,
      photoUrl: json['photoUrl'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/amanxz-social-media-app.appspot.com/o/default-avatar.jpg?alt=media&token=cb425243-0f53-49fe-a7a9-d935a4ba7339',
    );

Map<String, dynamic> _$$_ContactToJson(_$_Contact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'about': instance.about,
      'photoUrl': instance.photoUrl,
    };
