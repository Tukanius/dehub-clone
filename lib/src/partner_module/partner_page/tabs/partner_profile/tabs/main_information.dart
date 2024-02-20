import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainInformation extends StatefulWidget {
  const MainInformation({super.key});

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation> {
  bool edit = false;
  bool isEditted = false;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (edit == true)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  edit = false;
                });
              },
              backgroundColor: white,
              shape: const CircleBorder(
                side: BorderSide(
                  color: grey3,
                ),
              ),
              child: SvgPicture.asset(
                'assets/svg/remove.svg',
                colorFilter: const ColorFilter.mode(grey3, BlendMode.srcIn),
              ),
            ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              if (edit == true) {
                debugPrint('asdf');
              }
              setState(() {
                edit = !edit;
              });
            },
            backgroundColor: partnerColor,
            shape: const CircleBorder(),
            child: edit == false
                ? SvgPicture.asset(
                    'assets/svg/edit_rounded.svg',
                    colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
                  )
                : const Icon(
                    Icons.check,
                    color: white,
                  ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: FormBuilder(
            key: fbKey,
            onChanged: () {
              setState(() {
                isEditted = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'ҮНДСЭН МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Партнерийн код'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'partnerRef',
                    initialValue: 'PR-100016',
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Партнерийн категори'),
                  ),
                  selectionField(
                    text: 'Корпорэйт',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Бүртгэсэн'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'regUser',
                    initialValue: 'PR-100016',
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Бүртгэсэн огноо, цаг'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'date',
                    readOnly: true,
                    initialValue: 'PR-100016',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Регистр/Татвар төлөгчийн дугаар'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'regNumber',
                    readOnly: !edit,
                    initialValue: 'PR-100016',
                    decoration: InputDecoration(
                      hintText: 'Регистр/Татвар төлөгчийн дугаар',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Улсын бүртгэлийн гэрчилгээ №'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'asdf',
                    readOnly: true,
                    initialValue: 'Улсын бүртгэлийн гэрчилгээ №',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Аж ахуйн нэгжийн нэр'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'name',
                    readOnly: !edit,
                    initialValue: 'Компани М',
                    decoration: InputDecoration(
                      hintText: 'Аж ахуйн нэгжийн нэр',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Аж ахуйн нэгжийн нэр/Латин/'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'nameEng',
                    readOnly: !edit,
                    initialValue: 'Company M',
                    decoration: InputDecoration(
                      hintText: 'Аж ахуйн нэгжийн нэр/Латин/',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Аж ахуйн нэгжийн хэлбэр'),
                  ),
                  selectionField(
                    text: 'Хувьцаат компани',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Улсын харьяалал'),
                  ),
                  selectionField(
                    text: 'Монгол',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Өмчийн хэлбэр'),
                  ),
                  selectionField(
                    text: 'Монгол улсын иргэн, аж ахуйн нэгжийн',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'ХОЛБОО БАРИХ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Веб сайтын хаяг'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'province',
                    readOnly: !edit,
                    initialValue: 'Веб сайтын хаяг',
                    decoration: InputDecoration(
                      hintText: 'Веб сайтын хаяг',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('И-мэйл хаяг №1'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'email1',
                    readOnly: !edit,
                    initialValue: 'email',
                    decoration: InputDecoration(
                      hintText: 'И-мэйл хаяг №1',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('И-мэйл хаяг №2'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'email2',
                    readOnly: !edit,
                    initialValue: 'email2',
                    decoration: InputDecoration(
                      hintText: 'И-мэйл хаяг №2',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Утасны дугаар №1'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'phone1',
                    readOnly: !edit,
                    initialValue: 'phone1',
                    decoration: InputDecoration(
                      hintText: 'Утасны дугаар №1',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Утасны дугаар №2'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'phone2',
                    readOnly: !edit,
                    initialValue: 'phone2',
                    decoration: InputDecoration(
                      hintText: 'Утасны дугаар №2',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Facebook хаяг'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'facebook',
                    readOnly: !edit,
                    initialValue: 'Facebook хаяг',
                    decoration: InputDecoration(
                      hintText: 'Facebook хаяг',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'ХАЯГ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Аймаг, нийслэл'),
                  ),
                  selectionField(
                    text: 'Улаанбаатар',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Сум, дүүрэг'),
                  ),
                  selectionField(
                    text: 'Баянгол дүүрэг',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Баг, хороо'),
                  ),
                  selectionField(
                    text: 'Үйлдвэрийн төвийн бүс-1',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хороолол, гудамж'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'khoroo',
                    readOnly: !edit,
                    initialValue: '1',
                    decoration: InputDecoration(
                      hintText: 'Хороолол, гудамж',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хотхон, байр'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'khotkhon',
                    readOnly: !edit,
                    initialValue: '1',
                    decoration: InputDecoration(
                      hintText: 'Хотхон, байр',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хашаа, давхар'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'khashaa',
                    readOnly: !edit,
                    initialValue: '9 давхар',
                    decoration: InputDecoration(
                      hintText: 'Хашаа, давхар',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хаалганы дугаар'),
                  ),
                  FormTextField(
                    textColor: edit == true ? black : grey2,
                    name: 'khaalga',
                    readOnly: !edit,
                    initialValue: '9 давхар',
                    decoration: InputDecoration(
                      hintText: 'Хаалганы дугаар',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: edit == true ? white : backgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectionField({required String text, required Function() onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: grey2.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(5),
          color: edit == true ? white : backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: edit == true ? black : grey2,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: edit == true ? grey2 : grey2.withOpacity(0.3),
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
