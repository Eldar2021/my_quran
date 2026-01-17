// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:mq_app_ui/mq_app_ui.dart';

// class QiblaWidget extends StatelessWidget {
//   const QiblaWidget({
//     required this.direction,
//     required this.qiblaAngle,
//     super.key,
//   });

//   final double direction;
//   final double qiblaAngle;

//   @override
//   Widget build(BuildContext context) {
//     double turns = direction / 360;
//     return SizedBox(
//       width: 100,
//       height: 100,
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//         ),
//         child: AnimatedRotation(
//           turns: turns,
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeOut,
//           child: Row(
//             children: [
//               Transform.rotate(
//                 angle: direction / 360,
//                 child: Text(
//                   '${qiblaAngle.toStringAsFixed(0)}°',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Icon(
//                 Icons.arrow_forward_sharp,
//               ),
//               const Icon(Icons.currency_bitcoin),
//               // Assets.icons.qyblaDirection.svg(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
