import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe; // New property to determine if the message is sent by the current user
  const ChatBubble({Key? key, required this.text, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget messageWidget = Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue : Color(0xFFF5ED),
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: isMe ? Colors.white : Colors.black),
      ),
    );

    if (isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          messageWidget,
          SizedBox(width: 12.0), // Add some spacing between the message and the profile picture
          const CircleAvatar(
            backgroundColor: Color(0xFFFFF5ED),
            child: Icon(Icons.account_circle_outlined, color: Colors.black),
            radius: 20,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color(0xFFF5ED),
            child: Icon(Icons.account_circle, color: Color(0xFFF5ED)),
          ),
          SizedBox(width: 8.0), // Add some spacing between the profile picture and the message
          messageWidget,
        ],
      );
    }
  }
}
