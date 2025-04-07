import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';
import '../utils/calculate.dart';
import '../utils/formatter.dart';

class AnalyticsScreen extends StatelessWidget {
  final TransactionController _transactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final chartHeight = screenHeight * 0.5;

    final categoryTotals = calculateTotalsByCategory(_transactionController.transactions);
    final categories = categoryTotals.keys.toList();
    final values = categoryTotals.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Distribution by Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),
            Container(
              height: chartHeight,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < categories.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(categories[value.toInt()], style: TextStyle(fontSize: 10)),
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(categories.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          color: Colors.blueAccent,
                          width: 20,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(categories[index][0].toUpperCase(), style: TextStyle(color: Colors.white)),
                      ),
                      title: Text(categories[index], style: TextStyle(fontWeight: FontWeight.w600)),
                      trailing: Text(formatCurrency(values[index]), style: TextStyle(color: Colors.black87)),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}