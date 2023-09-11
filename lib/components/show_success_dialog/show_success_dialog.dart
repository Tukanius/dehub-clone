import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showCustomDialog(BuildContext context, String labelText,
    {VoidCallback? onPressed}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 75),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Амжилттай',
                    style: TextStyle(
                        color: dark, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${labelText}',
                    textAlign: TextAlign.center,
                  ),
                  ButtonBar(
                    buttonMinWidth: 100,
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "Ойлголоо",
                          style: TextStyle(color: dark),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          if (onPressed != null) {
                            onPressed();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Lottie.asset('images/success.json', height: 150, repeat: false),
          ],
        ),
      );
    },
  );
}

// class ShowSuccessDialog {
//   final String? labelText;
//   final BuildContext? context;
//   final DialogService? dialogService;
//   final Function()? onClick;
//   final Duration duration = const Duration(milliseconds: 1500);

//   ShowSuccessDialog({
//     this.context,
//     this.dialogService,
//     this.labelText,
//     this.onClick,
//   });

//   showSuccess(ctx) async {
//     showDialog(
//       barrierDismissible: false,
//       context: context!,
//       builder: (context) {
//         return Container(
//           alignment: Alignment.center,
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(top: 75),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     const Text(
//                       'Амжилттай',
//                       style: TextStyle(
//                           color: dark,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Text(
//                       '${labelText}',
//                       textAlign: TextAlign.center,
//                     ),
//                     ButtonBar(
//                       buttonMinWidth: 100,
//                       alignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         TextButton(
//                           style: ButtonStyle(
//                             overlayColor:
//                                 MaterialStateProperty.all(Colors.transparent),
//                           ),
//                           child: const Text(
//                             "Буцах",
//                             style: TextStyle(color: dark),
//                           ),
//                           onPressed: onClick,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Lottie.asset('assets/lottie/success.json',
//                   height: 150, repeat: false),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
