import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
// import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/screens/invoice/payment_page/payment_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:moment_dart/moment_dart.dart';

class BasicInformationTab extends StatefulWidget {
  final String id;
  BasicInformationTab({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab>
    with AfterLayoutMixin {
  Invoice invoice = Invoice();
  General general = General();
  Invoice approval = Invoice();
  bool isLoading = true;
  User user = User();
  List<Invoice> fields = [];

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);
    setState(() {
      isLoading = false;
    });
    fields = [
      Invoice(
        firstName: "Нэхэмжлэл №",
        lastName: invoice.refCode,
      ),
      Invoice(
        firstName: "Нэхэмжлэл статус",
        lastName: invoiceStatus(),
      ),
      Invoice(
        firstName: "Төлбөрийн төлөв",
        lastName: invoicePaymentStatus(),
      ),
      Invoice(
        firstName: "Нийт дүн",
        lastName: Utils().formatCurrency(invoice.totalAmount.toString()),
      ),
      Invoice(
        firstName: "Төлсөн дүн",
        lastName: Utils().formatCurrency(invoice.paidAmount.toString()),
      ),
      Invoice(
        firstName: "Төлбөрийн үлдэгдэл",
        lastName: Utils().formatCurrency(invoice.amountToPay.toString()),
      ),
      Invoice(
        firstName: "Төлөх огноо",
        lastName: invoice.paymentDate == null ? "-" : invoice.getPaymentDate(),
      ),
      Invoice(
        firstName: "Хугацаа хэтрэлт",
        lastName: overdueStatus(),
      ),
      Invoice(
        firstName: "Баталсан огноо",
        lastName: invoice.confirmedDate == null
            ? '-'
            : Moment.parse(invoice.confirmedDate.toString())
                .format("YYYY-MM-DD"),
      ),
      Invoice(
        firstName: "Татвар төлөгч дугаар",
        lastName: invoice.receiverBusiness?.regNumber,
      ),
      Invoice(
        firstName: "Партнер нэр",
        lastName: invoice.receiverBusiness?.partner?.businessName,
      ),
      Invoice(
        firstName: "Партнер код",
        lastName: invoice.receiverBusiness?.partner?.refCode,
      ),
      Invoice(
        firstName: "Бизнес нэр",
        lastName: invoice.receiverBusiness?.profileName,
      ),
      Invoice(
        firstName: "Бизнес код",
        lastName: invoice.receiverBusiness?.refCode,
      ),
      Invoice(
        firstName: "Төлбөрийн нөхцөл",
        lastName: invoice.paymentTerm?.description,
      ),
      Invoice(
        firstName: "Бизнесийн хаяг",
        lastName: invoice.receiverBranch?.branchAddress,
      ),
      Invoice(
        firstName: "Санхүүгийн ажилтан",
        lastName: invoice.receiverFinUser?.firstName,
      ),
      Invoice(
        firstName: "Дансны мэдээлэл",
        lastName:
            '${invoice.receiverAcc?.number}, ${invoice.receiverAcc?.bankName}',
      ),
      Invoice(
        firstName: "PO дугаар",
        lastName: invoice.purchaseCode,
      ),
      Invoice(
        firstName: "Татвар төлөгч дугаар",
        lastName: invoice.senderBusiness?.regNumber,
      ),
      Invoice(
        firstName: "Партнер нэр",
        lastName: invoice.senderBusiness?.partner?.businessName,
      ),
      Invoice(
        firstName: "Партнер код",
        lastName: invoice.senderBusiness?.partner?.refCode,
      ),
      Invoice(
        firstName: "Бизнес нэр",
        lastName: invoice.senderBusiness?.profileName,
      ),
      Invoice(
        firstName: "Бизнес код",
        lastName: invoice.senderBusiness?.refCode,
      ),
      Invoice(
        firstName: "Нэхэмжлэх бичсэн",
        lastName: invoice.getsentDate(),
      ),
      Invoice(
        firstName: "Бизнесийн хаяг",
        lastName: invoice.senderBranch?.branchAddress,
      ),
      Invoice(
        firstName: "Санхүүгийн ажилтан",
        lastName: invoice.senderFinUser?.firstName,
      ),
      Invoice(
        firstName: "Дансны мэдээлэл",
        lastName:
            '${invoice.senderAcc?.number}, ${invoice.senderAcc?.bankName}',
      ),
      Invoice(
        firstName: "SO дугаар",
        lastName: invoice.salesCode,
      ),
      Invoice(
        firstName: "Хөнгөлөлт",
        lastName: Utils().formatCurrency(invoice.discountAmount.toString()),
      ),
      Invoice(
        firstName: "Тооцсон НӨАТ",
        lastName: Utils().formatCurrency(invoice.vatAmount.toString()),
      ),
      Invoice(
        firstName: "Тооцсон НХАТ",
        lastName: Utils().formatCurrency(invoice.taxAmount.toString()),
      ),
      Invoice(
        firstName: "Хүргэлт төлбөр",
        lastName: Utils().formatCurrency(invoice.shippingAmount.toString()),
      ),
      Invoice(
        firstName: "Нийт төлбөр",
        lastName: Utils().formatCurrency(invoice.totalAmount.toString()),
      ),
    ];
  }

  approve(bool confirm) async {
    try {
      approval = Invoice(
        confirm: confirm,
        respondText: '',
      );
      await InvoiceApi().respond(widget.id, approval);
      showCustomDialog(
        context,
        "Амжилттай баталлаа",
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint('=========err=========');
      debugPrint(e.toString());
      debugPrint('=========err=========');
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).general;
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: isLoading == true
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэхэмжлэх',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: fields
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldCard(
                                color: white,
                                marginHorizontal: 15,
                                marginVertical: 15,
                                labelText: e.firstName,
                                secondText: e.lastName,
                                secondTextColor: invoiceColor,
                                fontWeight: e.firstName == "Нийт төлбөр"
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize:
                                    e.firstName == "Нийт төлбөр" ? 16 : 14,
                              ),
                              e.firstName == "Баталсан огноо"
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                        'Худалдан авагч тал',
                                        style: TextStyle(
                                          color: grey3,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : e.firstName == "PO дугаар"
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text(
                                            'Нийлүүлэгч тал',
                                            style: TextStyle(
                                              color: grey3,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      : e.firstName == "SO дугаар"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                invoice.lines!.isNotEmpty
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 15,
                                                            vertical: 10),
                                                        child: Text(
                                                          'БАРАА, ҮЙЛЧИЛГЭЭ',
                                                          style: TextStyle(
                                                            color: grey3,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                Column(
                                                  children: invoice.lines!
                                                      .map(
                                                        (item) =>
                                                            AddProductCard(
                                                          readOnly: true,
                                                          data: item,
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  child: Text(
                                                    'Нэмэлт Тэмдэглэл',
                                                    style: TextStyle(
                                                      color: grey3,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 8),
                                                  height: 125,
                                                  color: white,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: grey3
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        '${invoice.description}'),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : e.firstName == "Хөнгөлөлт"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15,
                                                      bottom: 10,
                                                      top: 10),
                                                  child: Text(
                                                    'НИЙТ ТӨЛБӨР',
                                                    style: TextStyle(
                                                      color: grey3,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  invoice.additionalLines!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'НЭМЭЛТЭЭР',
                            style: TextStyle(
                              color: grey3,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Column(
                    children: invoice.additionalLines!
                        .map(
                          (e) => InvoiceAdditionalLine(
                            data: e,
                          ),
                        )
                        .toList(),
                  ),
                  invoice.attachments!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Хавсралт файл',
                            style: TextStyle(
                              color: grey3,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Column(
                    children: invoice.attachments!
                        .map(
                          (e) => Container(
                            color: white,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Файлын нэр',
                                  style: TextStyle(color: invoiceColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: grey3,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  user.currentBusiness?.type == "BUYER"
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 37),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Harah.routeName,
                                    arguments: HarahArguments(
                                      totalAmount: 1000,
                                      invoice: invoice,
                                      data: invoice.lines!,
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: white,
                                      size: 20,
                                    ),
                                    Text(
                                      'Харах',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              invoice.invoiceStatus == "CONFIRMED"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          InvoicePaymentPage.routeName,
                                          arguments:
                                              InvoicePaymentPageArguments(
                                            data: invoice,
                                            id: '',
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          SvgPicture.asset(
                                            'assets/svg/tuloh.svg',
                                            height: 14,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Төлөх',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        approve(true);
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Icon(
                                            Icons.approval,
                                            color: white,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Батлах',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                      height: 17,
                                      width: 17,
                                    ),
                                    Text(
                                      'Цуцлах',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                      height: 17,
                                      width: 17,
                                    ),
                                    Text(
                                      'Цуцлах',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : CustomButton(
                          labelText: "Харах",
                          labelColor: invoiceColor,
                          onClick: () {
                            Navigator.of(context).pushNamed(
                              Harah.routeName,
                              arguments: HarahArguments(
                                totalAmount: 1000,
                                invoice: invoice,
                                data: invoice.lines!,
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, innerBoxIsScrolled) => InvoicePaymentPage(
          id: widget.id,
          data: invoice,
        ),
      );
  overdueStatus() {
    switch (invoice.overdueStatus) {
      case "NORMAL":
        return "Хэвийн";
      case "ONE_TO_THREE":
        return "1-3 хоног";
      case "FOUR_TO_THIRTY":
        return "4-30 хоног";
      case "THIRTY_ONE_TO_SIXTY":
        return "31-60 хоног";
      case "SIXTY_ONE_TO_NINETY":
        return "61-90 хоног";
      case "MORE_THAN_NINETY":
        return "91 < хоног";
    }
  }

  invoicePaymentStatus() {
    switch (invoice.paymentStatus) {
      case "PENDING":
        return "Хүлээгдэж буй";
      case "DIVIDED":
        return "Хуваасан";
      case "OVER_DUE":
        return "Хугацаа хэтэрсэн";
      case "CLOSED":
        return "Хаасан";
      default:
    }
  }

  textColor() {
    switch (invoice.paymentStatus) {
      case "PENDING":
        return yellow;
      case "DIVIDED":
        return buttonColor;
      case "OVER_DUE":
        return red;
      case "CLOSED":
        return green;
      default:
    }
  }

  invoiceStatus() {
    switch (invoice.invoiceStatus) {
      case "DRAFT":
        return "Түр төлөв";
      case "SENT":
        return "Илгээсэн";
      case "CONFIRMED":
        return "Баталсан";
      case "REJECTED":
        return "Татгалзсан";
      case "RETURNED":
        return "Буцаасан";
      case "CLOSED":
        return "Хаасан";
      default:
    }
  }

  invoiceStatusColor() {
    switch (invoice.invoiceStatus) {
      case "DRAFT":
        return grey;
      case "SENT":
        return Colors.indigo;
      case "CONFIRMED":
        return Colors.lightBlue;
      case "REJECTED":
        return red;
      case "RETURNED":
        return Colors.pink;
      case "CLOSED":
        return green;
      default:
    }
  }
}
