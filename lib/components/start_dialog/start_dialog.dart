import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showStartDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DeHUB платформд татай морил!',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Та платформд бизнесээ төлөөлөх админаар бүртгүүлсэн байна. Та админ хэрэглэгчээр нэвтрэхдээ дараах мэдээллээр нэвтэрнэ. Мартуузаа',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нэвтрэх код',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: buttonColor.withOpacity(0.3),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  'PR-2132324',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Хэрэглэгчийн нэр',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: buttonColor.withOpacity(0.3),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  'Username',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Та байгууллагыг төлөөлөх админ хэрэглэгчийн хувьд одоо ингэх ёстой',
                style: TextStyle(color: buttonColor),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset('assets/svg/blue-star.svg'),
              ),
              Text(
                'Хэрэглэгчийн зөвлөх',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Хэрэглэгчийн зөвлөх танд туслаад ингэнэ ингэнэ. йдыобрөйдылобрө',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onClick: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                },
                labelColor: buttonColor,
                labelText: 'Ок. Зөвлөгөө авъя.',
                textColor: white,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Гэрээлэх алхамууд',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'йбдөлор йдылобөр  дйлыробөдлйы ор др йдлоырбө дл йдлыобрө',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 25,
              ),
              SvgPicture.asset(
                'assets/svg/dollar-sign.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xff1B5EAA), BlendMode.srcIn),
              ),
            ],
          ),
        ),
      );
    },
  );
}
