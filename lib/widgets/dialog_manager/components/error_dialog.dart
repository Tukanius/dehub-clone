import 'package:dehub/services/dialog.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../dialog_wrapper.dart';

class ErrorDialog {
  final BuildContext? context;
  final DialogService? dialogService;
  final Duration duration = const Duration(seconds: 30);

  ErrorDialog({this.context, this.dialogService});

  void show(String message) {
    showDialog(
      context: context!,
      barrierDismissible: true,
      builder: (context) {
        Future.delayed(duration, () {
          dialogService!.dialogComplete();
          // ignore: unnecessary_null_comparison
          if (context == null) return;
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context).pop(true);
          }
        });
        return DialogWrapper(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 75),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.only(top: 90, left: 20, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Амжилтгүй',
                          style: TextStyle(
                              color: dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: black),
                        ),
                        ButtonBar(
                          buttonMinWidth: 100,
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: const Text(
                                "Ок",
                                style: TextStyle(color: dark),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Lottie.asset('assets/lottie/error.json',
                  height: 150, repeat: false)
            ],
          ),
        );
      },
    );
  }
}
