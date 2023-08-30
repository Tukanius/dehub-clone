import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';

class AddAttachment extends StatefulWidget {
  static const routeName = '/AddAttachment';
  const AddAttachment({super.key});

  @override
  State<AddAttachment> createState() => _AddAttachmentState();
}

class _AddAttachmentState extends State<AddAttachment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: Text(
          'Файлын нэр',
          style: TextStyle(
            color: buttonColor,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              FormTextField(
                textColor: orderColor,
                textAlign: TextAlign.end,
                name: 'name',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: white,
                  filled: true,
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(
                    color: orderColor,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Нэр',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 120,
                color: white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: grey),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Файл сонгох',
                      style: TextStyle(color: buttonColor),
                    ),
                    Row(
                      children: [
                        Text(
                          'Сонгох',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: orderColor,
                          size: 14,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 70),
            child: CustomButton(
              isGradient: true,
              onClick: () {},
              labelText: "Болсон. Нэмье",
            ),
          )
        ],
      ),
    );
  }
}
