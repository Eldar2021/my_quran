import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MqHalfCircleChart extends StatelessWidget {
  const MqHalfCircleChart({
    this.height = 250,
    this.innerRadius = 85,
    this.annotationFontSize = 18,
    this.dataSource = const [20, 30, 50],
    this.colors = const [AppColors.tomato2, AppColors.goldenrod, AppColors.mediumseagreen],
    this.annotation = '26\nTotal pages',
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
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.6,
        child: SizedBox(
          height: height,
          width: height,
          child: SfCircularChart(
            palette: colors,
            annotations: [
              CircularChartAnnotation(
                verticalAlignment: ChartAlignment.far,
                widget: Text(
                  annotation,
                  textAlign: TextAlign.center,
                  style: prTextTheme.titleLarge?.copyWith(fontSize: annotationFontSize),
                ),
              ),
            ],
            series: [
              DoughnutSeries<int, String>(
                dataSource: dataSource,
                xValueMapper: (data, _) => data.toString(),
                yValueMapper: (data, _) => data,
                groupTo: 3,
                startAngle: 270,
                endAngle: 90,
                innerRadius: '$innerRadius%',
                strokeColor: colorScheme.surface,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
