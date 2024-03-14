import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/src/invoice_module/components/payment_register_card/payment_register_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/invoice_module/screens/sheets/business_select_sheet.dart';
import 'package:dehub/src/invoice_module/screens/sheets/select_payment_method.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentRegister extends StatefulWidget {
  static const routeName = '/PaymentRegister';
  const PaymentRegister({super.key});

  @override
  State<PaymentRegister> createState() => PaymentRegisterState();
}

class PaymentRegisterState extends State<PaymentRegister>
    with AfterLayoutMixin {
  Result business = Result(rows: []);
  bool isLoading = true;
  General general = General();
  int page = 1;
  int limit = 10;
  Result invoices = Result(rows: [], count: 0);
  List<Invoice> selected = [];
  double received = 0;
  RefreshController refreshController = RefreshController();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  ListenController listenController = ListenController();

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  list(page, limit) async {
    final source = Provider.of<InvoiceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      Offset offset = Offset(page: page, limit: limit);
      Filter filter = Filter(receiverBusinessId: source.invoice.id);
      invoices = await InvoiceApi().historyInvoiceList(
        ResultArguments(filter: filter, offset: offset),
      );
      setState(() {
        selected = [];
      });
      loading.loading(false);
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<InvoiceProvider>(context, listen: false).clearData();
    business = await InvoiceApi().businessSelect();
    setState(() {
      isLoading = false;
    });
  }

  paymentMethod() {
    final source = Provider.of<InvoiceProvider>(context, listen: false);
    if (source.invoice.paymentMethod == null) {
      return 'Сонгох';
    } else {
      final res = general.paymentMethod!.firstWhere(
          (element) => element.code == source.invoice.paymentMethod);
      return res.name;
    }
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    final source = Provider.of<InvoiceProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        int index = selected.indexWhere((element) => element.amount == 0);
        List<Invoice> selectedList = [];
        loading.loading(true);
        Invoice data = Invoice.fromJson(fbkey.currentState!.value);
        data.totalAmount = received;
        data.receiverBusinessId = source.invoice.id;
        data.paymentMethod = source.invoice.paymentMethod;
        for (var data in selected) {
          selectedList.add(
            Invoice(
              invoiceId: data.id,
              amount: data.amount,
            ),
          );
        }
        data.invoices = selectedList;
        if (source.invoice.paymentMethod == null) {
          showCustomDialog(context, "Төлбөрийн хэлбэр сонгоно уу", false);
        } else if (index > -1) {
          showCustomDialog(
              context,
              "Сонгосон нэхэмжлэх болгонд тус бүрийн үнийн дүн оруулах ёстой",
              false);
        } else {
          await InvoiceApi().historyCreate(data);
          showCustomDialog(context, "Амжилттай төлбөр бүртгэлээ", true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        }
        loading.loading(false);
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          title: const Text(
            'Төлбөр бүртгэх',
            style: TextStyle(
              color: invoiceColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: invoiceColor),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              )
            : NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: FormBuilder(
                        key: fbkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Бизнес сонгох',
                              secondText:
                                  source.invoice.profileName ?? 'Сонгох',
                              color: white,
                              secondTextColor: invoiceColor,
                              arrowColor: invoiceColor,
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => BusinessSelectSheet(
                                    api: () {
                                      list(page, limit);
                                    },
                                    data: business.rows!,
                                  ),
                                );
                              },
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Төлбөрийн хэлбэр',
                              secondText: paymentMethod(),
                              color: white,
                              secondTextColor: invoiceColor,
                              arrowColor: invoiceColor,
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const SelectPaymentMethod(),
                                );
                              },
                            ),
                            FormTextField(
                              textColor: invoiceColor,
                              inputType: TextInputType.number,
                              fontSize: 14,
                              textAlign: TextAlign.end,
                              name: "asdf",
                              onChanged: (value) {
                                setState(() {
                                  received = double.tryParse(
                                          Utils().parseCurrency(value)) ??
                                      0;
                                });
                              },
                              inputFormatters: [CurrencyInputFormatter()],
                              decoration: const InputDecoration(
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(color: invoiceColor),
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Мөнгөн дүн'),
                                  ],
                                ),
                                fillColor: white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна',
                                ),
                              ]),
                            ),
                            FormTextField(
                              textColor: invoiceColor,
                              fontSize: 14,
                              textAlign: TextAlign.end,
                              name: "trxRefCode",
                              decoration: const InputDecoration(
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(color: invoiceColor),
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Лавлах дугаар'),
                                  ],
                                ),
                                fillColor: white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна',
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Column(
                  children: [
                    Expanded(
                      child: Refresher(
                        refreshController: refreshController,
                        onLoading: invoices.rows!.length == invoices.count
                            ? null
                            : onLoading,
                        color: invoiceColor,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (invoices.rows!.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Text(
                                    'Нэхэмжлэхийн жагсаалт',
                                    style: TextStyle(
                                      color: grey3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              Column(
                                children: invoices.rows!
                                    .map(
                                      (data) => PaymentRegisterCard(
                                        received: received,
                                        listenController: listenController,
                                        list: selected,
                                        data: data,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (selected.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 40, left: 15, right: 15, top: 20),
                        decoration: const BoxDecoration(
                          color: white,
                          border: Border(
                            top: BorderSide(color: invoiceColor, width: 2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Хүлээн авсан:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${Utils().formatCurrency(received.toString())}₮',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: invoiceColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Бүртгэсэн:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${Utils().formatCurrency((selected.fold(0.0, (previousValue, element) => previousValue + element.amount!).toString()))}₮',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: invoiceColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Зөрүү:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${Utils().formatCurrency((received - selected.fold(0.0, (previousValue, element) => previousValue + element.amount!)).toString())}₮',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: invoiceColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: onSubmit,
                              child: Container(
                                color: transparent,
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.app_registration_rounded,
                                      color: invoiceColor,
                                    ),
                                    Text(
                                      'Бүртгэх',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
