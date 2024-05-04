import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutterapp/model/cry_reason.dart';

class CustomPieChart extends StatelessWidget {
  final List<CryReason> data;

  CustomPieChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {for (var d in data) d.reason: d.percentage};
    final colorList = <Color>[
      Color(0xFF2656AB), // Deep blue color
      Color(0xFF1CE4E0), // Bright teal color
      Color(0xFFBA73F9), // Light purple color
    ]; // Customize more colors as needed

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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16), // Padding inside the box
      margin: const EdgeInsets.all(8), // Margin around the box
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 40,
        chartRadius: MediaQuery.of(context).size.width / 3,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 18,
        legendOptions: LegendOptions(
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            height: 2.5, // Adjust this value for different line spacings
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: false, // Do not show values on the chart
          showChartValuesInPercentage: true,
        ),
        totalValue: data.map((e) => e.percentage).reduce((a, b) => a + b),
      ),
    );
  }
}
