import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Barchart extends StatelessWidget {
  const Barchart({super.key, required this.data});

  final List<Expense> data;

  List<ExpenseBucket> get buckets {
    List<ExpenseBucket> output = [];
    for (var category in ExpenseCategoty.values) {
      ExpenseBucket bucket = ExpenseBucket.forCategory(
        category: category,
        allExpenses: data,
      );
      output.add(bucket);
    }
    return output;
  }

  double get _maxYAxis {
    if (buckets.isEmpty) return 10;

    double maxAmount = buckets
        .map((b) => b.totalExpenses)
        .reduce((a, curr) => a > curr ? a : curr);
    return maxAmount + (maxAmount * 0.2);
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> getBarGroups() {
      List<BarChartGroupData> output = [];
      for (var i = 0; i < buckets.length; i++) {
        output.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: buckets[i].totalExpenses,
                borderRadius: BorderRadius.zero,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
        );
      }
      return output;
    }

    BarTouchData getBarTouchData() {
      return BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(18),
      child: AspectRatio(
        aspectRatio: 2,
        child: Card(
          elevation: 0,
          child: BarChart(
            BarChartData(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              alignment: BarChartAlignment.spaceAround,
              maxY: _maxYAxis + 10,
              barTouchData: getBarTouchData(),
              titlesData: getTitlesData(),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups: getBarGroups(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    for (var i = 0; i < buckets.length; i++) {
      if (value.toInt() == i) {
        return SideTitleWidget(
          meta: meta,
          space: 8,
          child: Icon(categoryIcons[buckets[i].category], size: 18),
        );
      }
    }
    return SideTitleWidget(meta: meta, child: Icon(Icons.stop));
  }

  FlTitlesData getTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 34,
          showTitles: true,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
