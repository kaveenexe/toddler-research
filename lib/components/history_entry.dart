import 'package:flutter/material.dart';
import 'package:flutterapp/components/records.dart'; // Adjust the path as necessary
import 'package:flutterapp/components/table.dart'; // Adjust the path as necessary
import 'package:flutterapp/model/cry_reason.dart'; // Adjust the path as necessary

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
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: customGary,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Image.asset('assets/cry_dark.jpg'),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTime,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  reason,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
