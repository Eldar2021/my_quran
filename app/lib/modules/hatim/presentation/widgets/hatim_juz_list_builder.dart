import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HatimJuzListBuilder extends StatelessWidget {
  const HatimJuzListBuilder(this.items, {super.key});

  final List<HatimJusEntity> items;

  @override
  Widget build(BuildContext context) {
    final completedItems = items.where((item) => [20, 21, 23].contains(item.done)).length;

    final gaugeValue = (completedItems / 30) * 100;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 14, 70),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    startAngle: 180,
                    endAngle: 0,
                    showLabels: false,
                    canScaleToFit: true,
                    showTicks: false,
                    radiusFactor: 1.4,
                    axisLineStyle: const AxisLineStyle(color: Color(0xFFE3E3E5)),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: gaugeValue,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationDuration: 1200,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient:
                            const SweepGradient(colors: <Color>[Color(0xFFA851FA), Color.fromARGB(255, 206, 165, 241)]),
                        color: const Color(0xFF00A8B5),
                        width: 0.1,
                      ),
                    ],
                    annotations: const <GaugeAnnotation>[
                      GaugeAnnotation(
                        axisValue: 50,
                        positionFactor: 0.4,
                        widget: Text(
                          'ثلاثون جزء',
                          style: TextStyle(
                            color: Color(0xffD17CAC),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('${context.l10n.alreadyRead}: $completedItems ${context.l10n.juzFrom30}'),
            const SizedBox(height: 30),
            Column(
              children: [
                _buildLegendRow(context, context.l10n.notSelected, const Color(0xffF6684E)),
                const SizedBox(height: 8),
                _buildLegendRow(context, context.l10n.reading, const Color(0xffFFCADC)),
                const SizedBox(height: 8),
                _buildLegendRow(context, context.l10n.readed, const Color(0xffA851FA)),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              key: const Key(MqKeys.hatimJuzsList),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                final endAngleTodo = (item.toDo / 20) * 500;
                final endAngleDone = (item.done / 20) * 500;
                final endAngleInProgress = (item.inProgress / 20) * 500;

                return GestureDetector(
                  onTap: () async {
                    MqAnalytic.track(
                      AnalyticKey.selectHatimJuz,
                      params: {'juzId': item.id},
                    );
                    final bloc = context.read<HatimBloc>();

                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => BlocProvider.value(
                          value: bloc..add(GetHatimJuzPagesEvent(item.id)),
                          child: HatimJusSelectPagesView(hatimJusEntity: item),
                        ),
                      ),
                    );
                    bloc.add(const ResetJuzPagesEvent());
                  },
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        endAngle: endAngleTodo,
                        showTicks: false,
                        showLabels: false,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffF6684E)),
                      ),
                      RadialAxis(
                        endAngle: endAngleInProgress,
                        showTicks: false,
                        showLabels: false,
                        radiusFactor: 0.85,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffFFDEEA)),
                      ),
                      RadialAxis(
                        endAngle: endAngleDone,
                        showTicks: false,
                        radiusFactor: 0.75,
                        showLabels: false,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffA851FA)),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            positionFactor: 0.7,
                            angle: 90,
                            widget: _buildJuzAnnotation(context, item),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendRow(BuildContext context, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(' $text ', style: const TextStyle(fontSize: 12)),
        Container(
          width: 18,
          height: 18,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: CircleAvatar(
            backgroundColor: color,
          ),
        ),
      ],
    );
  }

  // Helper method to build the juz annotation widget
  Widget _buildJuzAnnotation(BuildContext context, HatimJusEntity item) {
    return Column(
      children: [
        Text(
          '${item.number}-${context.l10n.juz}',
          style: const TextStyle(
            color: Color(0xff1C274C),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 5),
        _buildProgressRow(context, item.done, context.l10n.pages, const Color(0xffA851FA)),
        _buildProgressRow(context, item.inProgress, context.l10n.pages, const Color(0xffFFCADC)),
        _buildProgressRow(context, item.toDo, context.l10n.pages, const Color(0xffF6684E)),
      ],
    );
  }

  // Helper method to build a row showing progress details
  Widget _buildProgressRow(BuildContext context, int count, String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '$count ',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff1C274C),
            ),
            children: [
              TextSpan(
                text: ' $label  ',
                style: const TextStyle(
                  color: Color(0xff666666),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 3.5,
          backgroundColor: color,
        ),
      ],
    );
  }
}
