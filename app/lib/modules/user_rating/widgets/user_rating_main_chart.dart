import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const hourAxisName = 'hour-axis';
const hour = 'Hour';
const page = 'Page';

class UserRatingMainChart extends StatelessWidget {
  const UserRatingMainChart(this.chartData, {super.key});

  final List<UserRatingMainChartData> chartData;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).languageCode;
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      backgroundColor: colors.surfaceContainerLow,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.none,
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        isVisible: false,
      ),
      axes: const <ChartAxis>[
        NumericAxis(
          name: hourAxisName,
          opposedPosition: true,
          isVisible: false,
          majorGridLines: MajorGridLines(width: 0),
        ),
      ],
      series: <CartesianSeries<UserRatingMainChartData, String>>[
        ColumnSeries<UserRatingMainChartData, String>(
          spacing: 0.5,
          dataSource: chartData,
          xValueMapper: (UserRatingMainChartData data, _) => data.dayOfTheWeek(locale),
          yValueMapper: (UserRatingMainChartData data, _) => data.pages,
          name: page,
          color: AppColors.tomato,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        ColumnSeries<UserRatingMainChartData, String>(
          spacing: 0.5,
          dataSource: chartData,
          xValueMapper: (UserRatingMainChartData data, _) => data.dayOfTheWeek(locale),
          yValueMapper: (UserRatingMainChartData data, _) => data.hours,
          name: hour,
          color: AppColors.darkslateblue,
          yAxisName: hourAxisName,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
      ],
    );
  }
}

@immutable
final class UserRatingMainChartData extends Equatable {
  const UserRatingMainChartData(
    this.date,
    this.pages,
    this.hours,
  );

  final DateTime date;
  final int pages;
  final int hours;

  String dayOfTheWeek(String locale) {
    return DateFormat.E(locale).format(date).toUpperCase();
  }

  @override
  List<Object?> get props => [
    date,
    pages,
    hours,
  ];
}
