import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MqCircularChart extends StatelessWidget {
  const MqCircularChart({
    this.height = 100,
    this.innerRadius = 85,
    this.annotationFontSize = 18,
    this.dataSource = const [20, 30, 50],
    this.colors = const [AppColors.tomato2, AppColors.goldenrod, AppColors.mediumseagreen],
    this.annotation = '',
    super.key,
  });

  final double height;
  final double innerRadius;
  final double annotationFontSize;
  final List<Color> colors;
  final String annotation;
  final List<int> dataSource;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return SizedBox(
      height: height,
      width: height,
      child: SfCircularChart(
        palette: colors,
        annotations: [
          CircularChartAnnotation(
            widget: Text(annotation, style: prTextTheme.titleLarge?.copyWith(fontSize: annotationFontSize)),
          ),
        ],
        series: [
          DoughnutSeries<int, String>(
            dataSource: dataSource,
            xValueMapper: (data, x) => data.toString(),
            yValueMapper: (data, y) => data,
            innerRadius: '$innerRadius%',
          ),
        ],
      ),
    );
  }
}
