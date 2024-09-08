// chat_bubble.dart
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({Key? key, required this.text, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFFFF7000) : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
