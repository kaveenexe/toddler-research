import 'package:flutter/material.dart';
import 'package:flutterapp/components/ChatUI/SendButton_screen.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSubmit;

  const ChatInputField({Key? key, required this.textController, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Ask about your toddler...',
              ),
              onSubmitted: onSubmit,
            ),
          ),
          SendButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                onSubmit(textController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

