import 'package:flutter/material.dart';

const Color customGary = Color.fromARGB(255, 237, 237, 237);

class HistoryEntry extends StatelessWidget {
  final String dateTime;
  final String reason;

  const HistoryEntry({
    Key? key,
    required this.dateTime,
    required this.reason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), // Space between cards
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 228, 228, 228).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: customGary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset('assets/cry_dark.jpg'),
          ),
        ),
        title:
            Text(dateTime, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(reason),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
