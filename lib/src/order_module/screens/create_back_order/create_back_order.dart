import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/back_order_create_card/back_order_create_card.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateBackOrderArguments {
  List<Order> orders;
  CreateBackOrderArguments({
    required this.orders,
  });
}

class CreateBackOrder extends StatefulWidget {
  static const routeName = '/CreateBackOrder';
  final List<Order> orders;
  const CreateBackOrder({
    super.key,
    required this.orders,
  });

  @override
  State<CreateBackOrder> createState() => CreateBackOrderState();
}

class CreateBackOrderState extends State<CreateBackOrder>
    with AfterLayoutMixin {
  DateTime date = DateTime.now();
  bool isLoading = true;
  Result lines = Result(rows: []);
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  List<String> ids = [];

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    int? index;
    List<Order> lines = [];
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        try {
          index = this.lines.rows!.indexWhere((element) =>
              element.receiverBranch.id == null ||
              element.receiverStaff.id == null);
        } catch (e) {
          showCustomDialog(context, "Талбаруудыг бүрэн бөглөнө үү", false);
        }
        if (index! < 0) {
          loading.loading(true);
          Order data = Order.fromJson(fbkey.currentState!.value);
          data.deliveryDate = date.toString();
          data.orderIds = ids;
          for (var i = 0; i < this.lines.rows!.length; i++) {
            lines.add(
              Order(
                variantId: this.lines.rows![i].variantId,
                buyerBusinessId: this.lines.rows![i].buyerBusiness.id,
                supplierBusinessId: this.lines.rows![i].supplierBusiness.id,
                receiverBranchId: this.lines.rows![i].receiverBranch.id,
                receiverStaffId: this.lines.rows![i].receiverStaff.id,
                quantity: this.lines.rows![i].quantity,
              ),
            );
          }
          data.lines = lines;
          if (this.lines.rows!.isNotEmpty) {
            await OrderApi().backorderCreate(data);
            showCustomDialog(context, "Амжилттай захиалга багцаллаа", true,
                onPressed: () {
              Navigator.of(context).pop();
            });
          } else {
            showCustomDialog(context, 'Багцлах бараа хоосон байна', false);
          }
          loading.loading(false);
        }
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    for (var data in widget.orders) {
      ids.add(data.id!);
    }
    lines = await OrderApi().getLines(Order(orderIds: ids));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: orderColor),
          surfaceTintColor: white,
          backgroundColor: white,
          title: const Text(
            'Захиалга багцлах',
            style: TextStyle(
              color: orderColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: orderColor,
                ),
              )
            : SingleChildScrollView(
                child: FormBuilder(
                  key: fbkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          'Нөөц захиалах бизнесийн мэдээлэл',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Хүлээн авах өдөр',
                        color: white,
                        secondText: DateFormat('yyyy-MM-dd').format(date),
                        secondTextColor: orderColor,
                        arrowColor: orderColor,
                        onClick: () {
                          datePick();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: FormTextField(
                          textColor: black,
                          name: 'senderAdditionalNote',
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Хүргэлтийн нэмэлт тэмдэглэл',
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
                            fillColor: white,
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Заавал оруулна',
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          'Багцлах захиалах мэдээлэл',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      lines.rows!.isNotEmpty
                          ? Column(
                              children: lines.rows!
                                  .map(
                                    (data) => BackorderCreateCard(
                                      data: data,
                                    ),
                                  )
                                  .toList(),
                            )
                          : const NotFound(
                              module: "ORDER",
                              labelText: 'Хоосон байна',
                            ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 4,
                            child: CustomButton(
                              onClick: () {},
                              labelText: 'Буцах',
                              labelColor: white,
                              borderColor: orderColor,
                              textColor: orderColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 6,
                            child: CustomButton(
                              onClick: onSubmit,
                              labelText: 'Захиалга үүсгэх',
                              labelColor: orderColor,
                              textColor: white,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  datePick() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      date = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
