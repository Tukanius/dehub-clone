import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_partner_category.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainInformation extends StatefulWidget {
  const MainInformation({super.key});

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation> {
  bool edit = false;
  bool isEditted = false;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  Partner user = Partner();
  Partner api = Partner();

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      Partner data = Partner.fromJson(fbKey.currentState!.value);
      await PartnerApi().profileUpdate(data);
      setState(() {
        edit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    final source = Provider.of<PartnerProvider>(context, listen: true);
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
                onSubmit();
              } else {
                setState(() {
                  edit = true;
                });
              }
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
                    initialValue: user.partner?.refCode,
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
                    text: source.partner.partnerCategory ?? 'Сонгоно уу',
                    onClick: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SelectPartnerCategory(),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Бүртгэсэн'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: '1',
                    initialValue:
                        '${user.user?.lastName?[0]}. ${user.user?.firstName}',
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
                    name: '2',
                    readOnly: true,
                    initialValue: DateFormat("yyyy-MM-dd HH:mm")
                        .format(user.partner!.createdAt!),
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
                    initialValue: '${user.partner?.regNumber}',
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
                    name: '3',
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
                    name: 'businessName',
                    readOnly: !edit,
                    initialValue: '${user.partner?.businessName}',
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
                    name: 'businessNameEng',
                    readOnly: !edit,
                    initialValue: '${user.partner?.businessNameEng}',
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
                    text: '${user.partner?.legalEntityType}',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Улсын харьяалал'),
                  ),
                  selectionField(
                    text: '${user.partner?.country}',
                    onClick: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Өмчийн хэлбэр'),
                  ),
                  selectionField(
                    text: '${user.partner?.equityType}',
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
                    name: 'web',
                    readOnly: !edit,
                    initialValue: user.partner?.web ?? '',
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
                    name: 'email',
                    readOnly: !edit,
                    initialValue: '${user.partner?.email}',
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
                    initialValue: user.partner?.email2 ?? '',
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
                    name: 'phone',
                    readOnly: !edit,
                    initialValue: user.partner?.phone,
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
                    initialValue: user.partner?.phone2 ?? '',
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
                    name: 'fbLink',
                    readOnly: !edit,
                    initialValue: user.partner?.fbLink ?? '',
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
                    name: 'khoroolol',
                    readOnly: !edit,
                    initialValue: user.partner?.khoroolol ?? '',
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
                    name: 'khotkhonBair',
                    readOnly: !edit,
                    initialValue: user.partner?.khotkhonBair ?? '',
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
                    name: 'khashaaDavkhar',
                    readOnly: !edit,
                    initialValue: user.partner?.khashaaDavkhar ?? '',
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
                    name: 'khaalgaDugaar',
                    readOnly: !edit,
                    initialValue: user.partner?.khaalgaDugaar ?? '',
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
