import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final String content;

  const InfoBox({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 12, horizontal: 20), // Adjust padding for better text fit
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 242, 242, 242),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            Text(title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 4),
            Text(content,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
