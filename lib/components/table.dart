import 'package:flutter/material.dart';
import 'package:flutterapp/model/cry_reason.dart';

class CustomLegendTable extends StatelessWidget {
  final List<CryReason> data;
  final List<Color> colors;

  const CustomLegendTable({Key? key, required this.data, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          // Optional: drop shadow
          BoxShadow(
            color: Color.fromARGB(255, 242, 242, 242).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      padding: const EdgeInsets.all(18), // Padding inside the box
      margin: const EdgeInsets.all(8), // Margin around the box
      child: Column(
        children: data.asMap().entries.map((entry) {
          int idx = entry.key;
          CryReason reason = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 0.0), // Adjusted for consistency
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: colors[idx],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(reason.reason,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
                Text('${reason.percentage.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
