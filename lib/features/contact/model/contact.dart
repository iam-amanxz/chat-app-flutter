import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String username,
    String? name,
    String? about,
    @Default('https://firebasestorage.googleapis.com/v0/b/amanxz-social-media-app.appspot.com/o/default-avatar.jpg?alt=media&token=cb425243-0f53-49fe-a7a9-d935a4ba7339')
        String? photoUrl,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
