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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 14, 70),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                    pointers: const <GaugePointer>[
                      RangePointer(
                        value: 60,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationDuration: 1200,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(colors: <Color>[Color(0xFFC992B1), Color(0xFFFFDEEA)]),
                        color: Color(0xFF00A8B5),
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
            Text('${context.l10n.alreadyRead}: ${items.where(
                  (item) => [
                    20,
                    21,
                    23,
                  ].contains(item.done),
                ).length} ${context.l10n.juzFrom30}'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${context.l10n.readed} ', style: const TextStyle(fontSize: 12)),
                Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffA851FA)),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffA851FA),
                  ),
                ),
                const SizedBox(width: 5),
                Text(' ${context.l10n.reading} ', style: const TextStyle(fontSize: 12)),
                Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffFFCADC)),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffFFCADC),
                  ),
                ),
                const SizedBox(width: 5),
                Text(' ${context.l10n.notSelected} ', style: const TextStyle(fontSize: 12)),
                Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffF6684E)),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffF6684E),
                  ),
                ),
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
                        endAngle: 490,
                        showTicks: false,
                        showLabels: false,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffF6684E)),
                      ),
                      RadialAxis(
                        showTicks: false,
                        showLabels: false,
                        radiusFactor: 0.85,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffFFDEEA)),
                      ),
                      RadialAxis(
                        endAngle: 350,
                        showTicks: false,
                        radiusFactor: 0.75,
                        showLabels: false,
                        axisLineStyle: const AxisLineStyle(thickness: 2, color: Color(0xffA851FA)),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            positionFactor: 0.7,
                            angle: 90,
                            widget: Column(
                              children: [
                                Text(
                                  '${item.number}-${context.l10n.juz}',
                                  style: const TextStyle(
                                    color: Color(0xff1C274C),
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '${item.done} ',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1C274C),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ${context.l10n.pages} ',
                                            style: const TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Color(0xffA851FA),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '${item.inProgress} ',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1C274C),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ${context.l10n.pages} ',
                                            style: const TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Color(0xffFFCADC),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '${item.toDo} ',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1C274C),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ${context.l10n.pages} ',
                                            style: const TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Color(0xffF6684E),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                // Card(
                //   child: Column(
                //     children: [
                //       ListTile(
                //         key: Key(MqKeys.hatimJuzIndex(index)),
                //         contentPadding: const EdgeInsets.all(8),
                //         title: Text('${item.number}-${context.l10n.juz}'),
                //         subtitle: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             VerticalText(context.l10n.hatimDoneRead, '${item.done}'),
                //             VerticalText(context.l10n.hatimProccessRead, '${item.inProgress}'),
                //             VerticalText(context.l10n.hatimEmptyRead, '${item.toDo}'),
                //           ],
                //         ),
                //         onTap: () async {
                //           MqAnalytic.track(
                //             AnalyticKey.selectHatimJuz,
                //             params: {'juzId': item.id},
                //           );
                //           final bloc = context.read<HatimBloc>();
                //           await AppBottomSheet.showBottomSheet<void>(
                //             context,
                //             scrollKey: const Key(MqKeys.hatimSelectPageScroll),
                //             initialChildSize: 0.85,
                //             BlocProvider.value(
                //               value: bloc..add(GetHatimJuzPagesEvent(item.id)),
                //               child: const HatimJusBottomSheet(),
                //             ),
                //           );
                //           bloc.add(const ResetJuzPagesEvent());
                //         },
                //       ),
                //       JuzPersentWidget(item),
                //     ],
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
