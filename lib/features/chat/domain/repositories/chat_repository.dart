import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/chat/domain/entities/check_chat_response.dart';


abstract class ChatRepository {
  const ChatRepository();

  ResultFuture<CheckChatResponse> getCategory();
}
