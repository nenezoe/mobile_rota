// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';

// class CustomFloatingActionButton extends StatelessWidget {
//   final bool isListening;
//   final VoidCallback onStartListening;
//   final VoidCallback onStopListening;
//   final VoidCallback onSend;

//   CustomFloatingActionButton({
//     required this.isListening,
//     required this.onStartListening,
//     required this.onStopListening,
//     required this.onSend,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AvatarGlow(
//       endRadius: 75.0,
//       animate: isListening,
//       duration: const Duration(milliseconds: 2000),
//       glowColor: Colors.white,
//       repeat: true,
//       repeatPauseDuration: const Duration(milliseconds: 100),
//       showTwoGlows: true,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             onPressed: () async {
//               await _editTextDialog(context, {'message': text});
//             },
//             color: Colors.white,
//             icon: Icon(Icons.edit_outlined),
//           ),
//           CircleAvatar(
//             backgroundColor: Color(0xff031c2b),
//             radius: 25,
//             // radius: 35,
//             // child: Image.asset('assets/images/mic.png'),
//             child: Icon(
//               isListening ? Icons.mic : Icons.mic_none,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               sendTextToApi(text);
//             },
//             color: Colors.white,
//             icon: Icon(
//               Icons.check,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }