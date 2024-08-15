import 'package:scholar_chat/widgets/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.id, this.message);

  factory Message.fromjson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
