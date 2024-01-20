import 'dart:io';
import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class RequestTab extends StatefulWidget {
  final Finance data;
  const RequestTab({
    super.key,
    required this.data,
  });

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  bool isSwitched = false;
  bool isLoading = true;
  PlatformFile? pickedFile;
  String? fileName;
  FilePickerResult? file;
  File? fileToDisplay;
  bool isFileEmpty = false;
  User user = User();

  void pickFile() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      file = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (file != null) {
        fileName = file!.files.first.name;
        pickedFile = file!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        setState(() {
          isFileEmpty = false;
        });
        debugPrint("File name $fileName");
        user = await AuthApi().uploadFile(pickedFile!);
        source.contractFile(user.url.toString());
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                'Хүсэлтийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлтийн код',
              secondText: 'Fin_Ref#',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлтийн төрөл',
              secondText: 'Эрт санхүүжилт',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нийлүүлэгч код',
              secondText: 'Supplier_Ref#',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нийлүүлэгч',
              secondText: 'Supplier_Name',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлт гаргасан',
              secondText: 'UserName_Supplier',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлтийн огноо',
              secondText: 'Request_Datetime',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хариу өгөх хугацаа',
              secondText: 'Response_date',
              secondTextColor: source.currentColor,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Хүсэлтийн төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey2, width: 1.5),
                    ),
                    child: Text(
                      'Draft',
                      style:
                          TextStyle(color: grey2, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хөтөлбөрийн нэр',
              secondText: 'ProgramName',
              secondTextColor: source.currentColor,
              onClick: () {},
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Бүтээгдэхүүн',
              secondText: 'SCF_Prod021',
              secondTextColor: source.currentColor,
              onClick: () {},
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                'Санхүүжилт хүсэх дүн',
                style: TextStyle(
                  color: grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: white,
              child: FormTextField(
                onChanged: (value) {
                  source.requestedAmount(double.tryParse(value));
                },
                initialValue: source.finance.requestedAmount != null
                    ? source.finance.requestedAmount?.toInt().toString()
                    : "",
                name: "amount",
                inputType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Санхүүжилт дүн',
                  hintStyle: TextStyle(
                    color: source.currentColor,
                    fontSize: 18,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: source.currentColor),
                  ),
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/svg/edit_rounded.svg',
                      colorFilter: ColorFilter.mode(black, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Санхүүжилт валют',
              secondText: 'Төгрөг',
              secondTextColor: source.currentColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                'Нөхцөл хангах байдал',
                style: TextStyle(
                  color: grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Боломжит доод дүн',
              secondText: 'Fin_Min_Amount',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Боломжит дээд дүн',
              secondText: 'Fin_Max_Amount',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нэх доод үлдэгдэл',
              secondText: 'Min_Inv_Balance',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нэх мах.тенор',
              secondText: 'Max_Tenor',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нэх min.тенор',
              secondText: 'Min_Tenor',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Санхүүжилт хоног',
              secondText: 'Day_Finance',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Шимтгэл тооцсон хувь',
              secondText: 'Тооцох',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Тооцсон шимтгэл',
              secondText: 'Шимтгэл ₮',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Санхүүжих шимтгэл',
              secondText: 'Trans_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Гүйлгээний шимтгэл',
              secondText: 'Trans_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Өргөдөл хураамж',
              secondText: 'Application_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Олголт шимтгэл',
              secondText: 'Disburse_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нийт шимтгэл',
              secondText: 'SUM_FEE',
              secondTextFontWeight: FontWeight.bold,
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Шимтгэл дүрэм',
              secondText: 'Санхүүжилт олгох үед',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Шимтгэл дээд дүн',
              secondText: 'Min_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Шимтгэл доод дүн',
              secondText: 'Max_Fee',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Эргэн төлөх хугацаа',
              secondText: 'Fin_Due_Date',
              secondTextColor: source.currentColor,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Буцаан дуудах эсэх',
                    style: TextStyle(color: dark),
                  ),
                  CustomSwitch(
                    isDefault: true,
                    color: Color(0xff151357),
                  ),
                ],
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Буцаан дуудах огноо',
              secondText: 'Тооцсон огноо',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Ху.Хэтрэлт алданги',
              secondText: 'Penalty Rate',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Алдангийн арга',
              secondText: 'Хэтэрсэн хоног',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Эргэн төлөх дүрэм',
              secondText: 'Алданга+Үндсэн',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нэхэмжлэх хугацаа',
              secondText: 'Хоног',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хугацааны Min шалгуур',
              secondText: 'Min_Day',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хугацааны Max шалгуур',
              secondText: 'Max_Day',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хугацаа хэтрэлт',
              secondText: 'Хэвийн',
              secondTextColor: source.currentColor,
            ),
            source.finance.productType != "BUYER_LED"
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      'Файл хавсаргах',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox(),
            source.finance.productType != "BUYER_LED"
                ? GestureDetector(
                    onTap: () {
                      pickFile();
                    },
                    child: Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/pdf_download.svg',
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Файл хавсаргах',
                                style: TextStyle(
                                  color: Color(0xff151357),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff151357),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
