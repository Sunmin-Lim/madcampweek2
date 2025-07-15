// // // warning_page.dart에서 여러 목록으로 보여주게 할 목적으로 사용할 것
// // import 'dart:async';
// // import 'package:flutter/material.dart';

// // class WarningMessage extends StatefulWidget {
// //   final String message;
// //   final VoidCallback? onDismissed;

// //   const WarningMessage({Key? key, required this.message, this.onDismissed})
// //     : super(key: key);

// //   @override
// //   _WarningMessageState createState() => _WarningMessageState();
// // }

// // class _WarningMessageState extends State<WarningMessage> {
// //   bool visible = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     Timer(const Duration(seconds: 5), () {
// //       if (mounted) {
// //         setState(() => visible = false);
// //         if (widget.onDismissed != null) widget.onDismissed!();
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedOpacity(
// //       opacity: visible ? 1.0 : 0.0,
// //       duration: const Duration(milliseconds: 300),
// //       child: visible
// //           ? Container(
// //               margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //               decoration: BoxDecoration(
// //                 color: Colors.orangeAccent,
// //                 borderRadius: BorderRadius.circular(8),
// //                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
// //               ),
// //               child: Text(
// //                 widget.message,
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             )
// //           : const SizedBox.shrink(),
// //     );
// //   }
// // }

// import 'dart:async';
// import 'package:flutter/material.dart';

// class WarningMessage extends StatefulWidget {
//   final String repoUrl;
//   final int remainingTime;
//   final VoidCallback? onDismissed;

//   const WarningMessage({
//     Key? key,
//     required this.repoUrl,
//     required this.remainingTime,
//     this.onDismissed,
//   }) : super(key: key);

//   @override
//   _WarningMessageState createState() => _WarningMessageState();
// }

// class _WarningMessageState extends State<WarningMessage> {
//   bool visible = true;

//   @override
//   void initState() {
//     super.initState();
//     // 5초 후 자동으로 사라지게 설정
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) {
//         setState(() => visible = false);
//         if (widget.onDismissed != null) widget.onDismissed!();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: visible ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 300),
//       child: visible
//           ? Container(
//               margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Github Repository Link: ${widget.repoUrl}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Remaining Time: ${widget.remainingTime ~/ 1000}s',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : const SizedBox.shrink(),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

class WarningMessage extends StatefulWidget {
  final String repoUrl;
  final int remainingTime;

  const WarningMessage({
    Key? key,
    required this.repoUrl,
    required this.remainingTime,
  }) : super(key: key);

  @override
  _WarningMessageState createState() => _WarningMessageState();
}

class _WarningMessageState extends State<WarningMessage> {
  bool visible = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => visible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: visible
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Github Repository Link: ${widget.repoUrl}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Remaining Time: ${widget.remainingTime ~/ 1000}s',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
