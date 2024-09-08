// chat_input_field.dart
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSubmit;

  const ChatInputField({Key? key, required this.textController, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: RichTextField(controller: textController),
            ),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                onSubmit(textController.text);
              }
            },
            backgroundColor: Color(0xFFf76e08), // Purple color for the button
            child: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class RichTextField extends StatelessWidget {
  final TextEditingController controller;

  const RichTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'ඔබගෙ ප්‍රශ්නය යොමු කරන්න...',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(fontSize: 16, color: Colors.black),
      onChanged: (text) {
        // Handle highlighting of specific text like 'HTML'
        // This is a simple implementation. You can customize it further for your needs.
        if (text.contains('HTML')) {
          controller.value = controller.value.copyWith(
            text: text.replaceAll('HTML', 'using HTML'),
            selection: TextSelection.fromPosition(
              TextPosition(offset: text.length),
            ),
          );
        }
      },
    );
  }
}
