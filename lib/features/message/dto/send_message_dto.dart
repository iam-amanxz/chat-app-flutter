class SendMessageDto {
  final String conversationId;
  final String content;
  final String receiverId;
  SendMessageDto({
    required this.conversationId,
    required this.content,
    required this.receiverId,
  });
}
