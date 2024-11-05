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
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                HatimStatusWidget(text: context.l10n.notSelected, color: const Color(0xffF6684E)),
                const SizedBox(height: 8),
                HatimStatusWidget(text: context.l10n.reading, color: const Color(0xffFFCADC)),
                const SizedBox(height: 8),
                HatimStatusWidget(text: context.l10n.readed, color: const Color(0xffA851FA)),
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
                final endAngleTodo = (item.toDo / 20) * 100;
                final endAngleDone = (item.done / 20) * 100;
                final endAngleInProgress = (item.inProgress / 20) * 100;
                return HatimJuzItemWidget(
                  endAngleTodo: endAngleTodo,
                  endAngleInProgress: endAngleInProgress,
                  endAngleDone: endAngleDone,
                  item: item,
                  index: index,
                  onTap: () => _onTap(item, context),
                );
              },
            ),
            const SizedBox(height: 65),
          ],
        ),
      ),
    );
  }

  Future<void> _onTap(HatimJusEntity item, BuildContext context) async {
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
  }
}

class HatimJuzItemWidget extends StatelessWidget {
  const HatimJuzItemWidget({
    required this.endAngleTodo,
    required this.endAngleInProgress,
    required this.endAngleDone,
    required this.item,
    required this.onTap,
    required this.index,
    super.key,
  });

  final double endAngleTodo;
  final double endAngleInProgress;
  final double endAngleDone;
  final HatimJusEntity item;
  final void Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          // onAxisTapped: (value) {
          //   log('2');
          // },
          startAngle: 0,
          endAngle: 0,
          showTicks: false,
          showLabels: false,
          axisLineStyle: AxisLineStyle(
            thickness: 2,
            color: const Color(0xffFFDEEA).withOpacity(0.5),
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: endAngleTodo,
              width: 0.03,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
              color: const Color(0xffF6684E),
            ),
          ],
        ),
        RadialAxis(
          startAngle: 0,
          endAngle: 0,
          showTicks: false,
          showLabels: false,
          radiusFactor: 0.85,
          axisLineStyle: AxisLineStyle(
            thickness: 2,
            color: const Color(0xffFFDEEA).withOpacity(0.4),
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: endAngleInProgress,
              width: 0.03,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
              color: const Color.fromARGB(255, 232, 168, 192),
            ),
          ],
        ),
        RadialAxis(
          startAngle: 0,
          endAngle: 0,
          showTicks: false,
          radiusFactor: 0.75,
          showLabels: false,
          axisLineStyle: AxisLineStyle(
            thickness: 2,
            color: const Color(0xffFFDEEA).withOpacity(0.4),
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: endAngleDone,
              width: 0.03,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
              color: const Color(0xffA851FA),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Center(
                child: InkWell(
                  onTap: onTap,
                  child: JuzAnnotationWidget(
                    key: Key(MqKeys.hatimJuzIndex(index)),
                    item: item,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
