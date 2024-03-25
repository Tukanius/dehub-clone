import 'dart:io';
import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class RequestTab extends StatefulWidget {
  final Finance data;
  final String userType;
  const RequestTab({
    super.key,
    required this.userType,
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
  double? feePerDay;
  int? day;
  General general = General();
  double calculatedFee = 0;
  double appFee = 0;
  double fee = 0;
  DateTime repaymentDate = DateTime.now();
  String? amount;
  double minOfInv = 0;
  double maxOfInv = 0;

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
        user = await AuthApi().uploadFile(pickedFile!, "finance");
        source.contractFiles(user.url.toString());
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.type == "SCF") {
      if (widget.data.program != null) {
        if (widget.userType == "SUPPLIER") {
          feePerDay = (widget.data.program!.product!.suppFee! /
              (widget.data.program!.product!.suppCalculateDay! * 100));
        } else {
          feePerDay = (widget.data.program!.product!.buyerFee! /
              (widget.data.program!.product!.buyerCalculateDay! * 100));
        }
      }
      day = widget.data.paymentDate?.difference(DateTime.now()).inDays;
      calculatedFee = source.finance.requestedAmount! * feePerDay! * day!;
      appFee = widget.data.program!.product!.suppAppFee!;
      fee = ((source.finance.requestedAmount! *
              (widget.userType == "SUPPLIER"
                  ? widget.data.program!.product!.suppDisbursementFee!
                  : widget.data.program!.product!.buyerDisbursementFee!)) /
          100);
      widget.userType == "SUPPLIER"
          ? widget.data.program?.product?.suppAppFee
          : widget.data.program?.product?.buyerAppFee;
      repaymentDate = widget.userType == "SUPPLIER"
          ? widget.data.paymentDate!
          : widget.data.paymentDate!.add(Duration(
              days: widget.data.program!.product!.buyerCalculateDay!.toInt(),
            ));
    } else {
      minOfInv = (source.finance.requestedAmount! *
              widget.data.lbfProgram!.lbfProduct!.minOfInv!) /
          100;
      maxOfInv = (source.finance.requestedAmount! *
              widget.data.lbfProgram!.lbfProduct!.maxOfInv!) /
          100;
    }
    super.initState();
  }

  feeRule() {
    final Object res;
    if (widget.userType == "SUPPLIER") {
      res = general.productSuppFeeRules!.firstWhere((element) =>
          element.code == widget.data.program?.product?.suppFeeRule);
    } else {
      res = general.productBuyerFeeRules!.firstWhere((element) =>
          element.code == widget.data.program?.product?.buyerFeeRule);
    }
    return res;
  }

  penaltyType() {
    final Object res;
    if (widget.userType == "SUPPLIER") {
      res = general.productSuppPenaltyTypes!.firstWhere((element) =>
          element.code == widget.data.program?.product?.suppPenaltyType);
    } else {
      res = general.productBuyerPenaltyTypes!.firstWhere((element) =>
          element.code == widget.data.program?.product?.buyerPenaltyType);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
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
              child: const Text(
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
              secondText: 'Авто үүснэ',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хамаарах бизнес',
              secondText:
                  '${user.currentBusiness?.profileName}, ${user.currentBusiness?.refCode}',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлт гаргаж буй',
              secondText:
                  '${widget.data.senderFinUser?.lastName?[0]}. ${widget.data.senderFinUser?.firstName}',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Харилцагчийн код',
              secondText: '${user.clientCode}',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Татвар төлөгчийн дугаар',
              secondText: '${user.currentBusiness?.regNumber}',
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хүсэлтийн огноо',
              secondText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Зээл төлөх огноо',
              secondText:
                  DateFormat('yyyy-MM-dd').format(widget.data.paymentDate!),
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хөтөлбөрийн нэр',
              secondText: widget.data.lbfProgram?.name,
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хөтөлбөрийн код',
              secondText: widget.data.lbfProgram?.refCode,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Бүтээгдэхүүний нэр',
              secondText: widget.data.lbfProgram?.lbfProduct?.name,
              secondTextColor: source.currentColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Бүтээгдэхүүний код',
              secondText: widget.data.lbfProgram?.lbfProduct?.refCode,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Хүсэлтийн төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey2, width: 1.5),
                    ),
                    child: const Text(
                      'Түр төлөв',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Хэмжээ шалгуур',
              secondText:
                  '${Utils().formatCurrency("${minOfInv.toInt()}")}₮ - ${Utils().formatCurrency("${maxOfInv.toInt()}")}₮',
              secondTextColor: source.currentColor,
            ),
            if (source.type == "SCF")
              Column(
                children: [
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Хөтөлбөрийн нэр',
                    secondText: '${widget.data.program?.name}',
                    secondTextColor: source.currentColor,
                    onClick: () {},
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бүтээгдэхүүн',
                    secondText: '${widget.data.program?.product?.name}',
                    secondTextColor: source.currentColor,
                    onClick: () {},
                  ),
                ],
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: const Text(
                'Нэхэмжлэхийн шалгуур хангах байдал',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text(
                      'Санхүүжилт хүсэх дүн',
                    ),
                  ),
                  FormTextField(
                    onChanged: (value) {
                      setState(() {
                        amount = Utils().parseCurrency(value);
                      });
                      source.requestedAmount(double.tryParse(amount!) ?? 0);
                    },
                    initialValue: Utils().formatCurrency("$maxOfInv"),
                    name: "amount",
                    inputFormatters: [CurrencyInputFormatter()],
                    inputType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Санхүүжилт дүн',
                      hintStyle: TextStyle(
                        color: source.currentColor,
                        fontSize: 18,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: source.currentColor),
                      ),
                      suffixIcon: Container(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svg/edit_rounded.svg',
                          colorFilter:
                              const ColorFilter.mode(black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      (value) {
                        double am = double.tryParse(amount!) ?? 0;
                        if (am > maxOfInv || am < minOfInv) {
                          return 'Хэмжээ шалгуур хангахгүй байна';
                        } else {
                          return null;
                        }
                      }
                    ]),
                  ),
                ],
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
            if (source.type == "SCF")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text(
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
                    secondText:
                        '${Utils().formatCurrency(((widget.data.amountToPay! * widget.data.program!.product!.minOfInv!) / 100).toString())}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Боломжит дээд дүн',
                    secondText:
                        '${Utils().formatCurrency(((widget.data.amountToPay! * widget.data.program!.product!.maxOfInv!) / 100).toString())}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нэхэмжлэхийн доод үлдэгдэл',
                    secondText:
                        '${Utils().formatCurrency(widget.data.program?.product?.minInvAmount.toString())}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нэхэмжлэхийн мах.тенор',
                    secondText:
                        '${widget.data.program?.product?.maxTenor?.toInt()}',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нэхэмжлэхийн min.тенор',
                    secondText:
                        '${widget.data.program?.product?.minTenor?.toInt()}',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Санхүүжилт хоног',
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? '$day хоног'
                        : "${widget.data.program?.product?.buyerTerm?.toInt()} хоног",
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Шимтгэл тооцсон хувь хоногт',
                    secondText: '${feePerDay?.toStringAsFixed(6)}%',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Тооцсон шимтгэл',
                    secondText: '${calculatedFee.toStringAsFixed(2)}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Өргөдөл хураамж',
                    secondText: '${Utils().formatCurrency(appFee.toString())}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Олголт шимтгэл',
                    secondText: '${Utils().formatCurrency(fee.toString())}₮',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нийт шимтгэл',
                    secondText:
                        '${Utils().formatCurrency((calculatedFee + appFee + fee).toString())}₮',
                    secondTextFontWeight: FontWeight.bold,
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Шимтгэл дүрэм',
                    secondText: '${feeRule().name}',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Шимтгэл доод дүн',
                    secondText: widget.userType == "SUPPLIER"
                        ? '${Utils().formatCurrency(widget.data.program?.product?.suppMinFee.toString())}₮'
                        : "${Utils().formatCurrency(widget.data.program?.product?.buyerMinFee.toString())}₮",
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Эргэн төлөх хугацаа',
                    secondText: DateFormat('yyyy-MM-dd').format(
                        repaymentDate.add(Duration(
                            days: widget.data.program!.product!.buyerTerm!
                                .toInt()))),
                    secondTextColor: source.currentColor,
                  ),
                  if (user.currentBusiness?.type == "SUPPLIER")
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Буцаан дуудах эсэх',
                            style: TextStyle(color: dark),
                          ),
                          CustomSwitch(
                            isDefault:
                                widget.data.program?.product?.recourseTerm,
                            color: const Color(0xff151357),
                          ),
                        ],
                      ),
                    ),
                  if (widget.data.program?.product?.recourseTerm == true &&
                      user.currentBusiness?.type == "SUPPLIER")
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 10,
                      color: white,
                      labelText: 'Буцаан дуудах огноо',
                      secondText: DateFormat('yyyy-MM-dd').format(
                        repaymentDate.add(
                          Duration(
                              days:
                                  widget.data.program!.product!.recourseDays!),
                        ),
                      ),
                      secondTextColor: source.currentColor,
                    ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Ху.Хэтрэлт алданги',
                    secondText: widget.userType == "SUPPLIER"
                        ? '${widget.data.program?.product?.suppPenaltyPercent}%'
                        : '${widget.data.program?.product?.buyerPenaltyPercent}%',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Алдангийн арга',
                    secondText: '${penaltyType().name}',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нэхэмжлэх хугацаа',
                    secondText:
                        '${DateTime.now().difference(widget.data.confirmedDate!).inDays} хоног',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Хугацааны Min шалгуур',
                    secondText:
                        '${widget.data.program?.product?.minDays?.toInt()} хоног',
                    secondTextColor: source.currentColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Хугацааны Max шалгуур',
                    secondText:
                        '${widget.data.program?.product?.maxDays?.toInt()} хоног',
                    secondTextColor: source.currentColor,
                  ),
                ],
              ),
            if (source.type == "SCF" &&
                    user.currentBusiness?.type == "BUYER" &&
                    user.clientType == "ANCHOR" ||
                source.type == "SCF" &&
                    user.currentBusiness?.type == "SUPPLIER" &&
                    user.clientType == "SME")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text(
                      'Файл хавсаргах',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickFile();
                    },
                    child: Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/pdf_download.svg',
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              fileName == null ? 'Файл хавсаргах' : '$fileName',
                              style: const TextStyle(
                                color: Color(0xff151357),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff151357),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
