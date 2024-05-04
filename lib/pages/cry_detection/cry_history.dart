import 'package:flutter/material.dart';
import 'package:flutterapp/components/records.dart'; // Ensure this path is correct

const Color customOrange = Color(0xFFFF7000);

class CryHistory extends StatelessWidget {
  CryHistory({Key? key}) : super(key: key);

  final List<Map<String, String>> cryingData = [
    {
      'dateTime': '16th of September, 2023 at 10:38pm',
      'reason': 'Noah cried due to hungry'
    },
    {
      'dateTime': '15th of September, 2023 at 08:21am',
      'reason': 'Noah cried due to pain'
    },
    {
      'dateTime': '11th of September, 2023 at 05:33pm',
      'reason': 'Noah cried due to hungry'
    },
    {
      'dateTime': '10th of September, 2023 at 02:54am',
      'reason': 'Noah cried due to belly pain'
    },
    {
      'dateTime': '9th of September, 2023 at 11:30am',
      'reason': 'Noah cried due to burp'
    },
    {
      'dateTime': '8th of September, 2023 at 07:47pm',
      'reason': 'Noah cried due to tired'
    },
    // Add more entries as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Crying History',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 18, // Set your desired font size
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true, // Centers the title in the AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cryingData.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return HistoryEntry(
                  dateTime: cryingData[index]['dateTime']!,
                  reason: cryingData[index]['reason']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25), // Added bottom margin
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back or to a specific screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: customOrange, // Use a constant color variable if needed
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: const Text(
                'GO TO HOME',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
