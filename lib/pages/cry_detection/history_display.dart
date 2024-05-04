import 'package:flutter/material.dart';
import 'package:flutterapp/components/table.dart';
import 'package:flutterapp/model/cry_reason.dart';
import 'package:flutterapp/components/history_entry.dart';

const Color customOrange = Color(0xFFFF7000);

class HistoryDisplay extends StatelessWidget {
  HistoryDisplay({Key? key}) : super(key: key);

  final List<CryReason> reasons = [
    CryReason(reason: "Hungry", percentage: 58.33),
    CryReason(reason: "Uncomfortable", percentage: 16.67),
    CryReason(reason: "Sleep", percentage: 25.00),
  ];

  final List<Color> colors = [
    Color(0xFF2656AB),
    Color(0xFF1CE4E0),
    Color(0xFFBA73F9),
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
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    Color.fromARGB(255, 189, 189, 189).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HistoryEntry(
                dateTime: '06th of September, 2023 at 10.38pm',
                reason: 'Noah cried due to hungry',
              ),
              CustomLegendTable(
                data: reasons,
                colors: colors,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: customOrange,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          ),
          child: const Text(
            'GO TO HOME',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
