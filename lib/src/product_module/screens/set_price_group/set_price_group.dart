import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/product_module/product_page/tabs/price_tab/components/price_setting_card.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SetPriceGroupArguments {
  List<InventoryGoods> list;
  ListenController listenController;
  SetPriceGroupArguments({
    required this.list,
    required this.listenController,
  });
}

class SetPriceGroup extends StatefulWidget {
  static const routeName = '/SetPriceGroup';
  final List<InventoryGoods> list;
  final ListenController listenController;
  const SetPriceGroup({
    super.key,
    required this.listenController,
    required this.list,
  });

  @override
  State<SetPriceGroup> createState() => _SetPriceGroupState();
}

class _SetPriceGroupState extends State<SetPriceGroup> with AfterLayoutMixin {
  General general = General();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String? groupType;
  String? groupTypeId;
  String? priceGroup;
  String? priceGroupId;
  String? tier;
  int? tierNo;
  bool groupTypeValidate = false;
  bool priceGroupValidate = false;
  bool tierValidate = false;
  var validateKey = GlobalKey();
  List<InventoryGoods> tiers = [];
  bool isLoading = true;
  bool isSubmit = false;
  Result group = Result(rows: [], count: 0);

  validateCheck(bool confirm) {
    if (groupType == null) {
      setState(() {
        groupTypeValidate = true;
      });
      Scrollable.ensureVisible(
        validateKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    if (priceGroup == null) {
      setState(() {
        priceGroupValidate = true;
      });
      Scrollable.ensureVisible(
        validateKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    if (tier == null) {
      setState(() {
        tierValidate = true;
      });
      Scrollable.ensureVisible(
        validateKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    if (tierValidate == false &&
        priceGroupValidate == false &&
        groupTypeValidate == false) {
      onSubmit(confirm);
    }
  }

  onSubmit(bool confirm) async {
    try {
      setState(() {
        isSubmit = true;
      });
      List<String> businessIds = [];
      InventoryGoods data = InventoryGoods(
        priceGroupType: groupTypeId,
        priceGroupId: priceGroupId,
        priceTierNo: tierNo,
        priceStartDate: startDate.toString(),
        priceEndDate: endDate.toString(),
        confirm: confirm,
      );
      for (var i = 0; i < widget.list.length; i++) {
        businessIds.add(widget.list[i].id!);
      }
      data.businessIds = businessIds;
      await InventoryApi().setPrice(data);
      widget.listenController.changeVariable('asdf');
      showCustomDialog(context, "Амжилттай", true, onPressed: () {
        Navigator.of(context).pop();
      });
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    group = await InventoryApi().priceGroupSelect("GROUP");
    tiers = general.tiers!.where((element) => element.isSet == true).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Үнийн бүлэг тохируулах',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Тохиргоо мэдээлэл',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: grey2,
                      ),
                    ),
                  ),
                  FieldCard(
                    fbKey: validateKey,
                    validate: groupTypeValidate,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бүлгийн төрөл',
                    secondText: groupType ?? 'Сонгох',
                    arrowColor: productColor,
                    secondTextColor: productColor,
                    onClick: () {
                      selectGroupType();
                    },
                  ),
                  FieldCard(
                    validate: priceGroupValidate,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Үнийн бүлэг',
                    secondText: priceGroup ?? 'Сонгох',
                    arrowColor: productColor,
                    secondTextColor: productColor,
                    onClick: () {
                      selectPriceGroup();
                    },
                  ),
                  FieldCard(
                    validate: tierValidate,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Tier сонгох',
                    secondText: tier ?? 'Сонгох',
                    arrowColor: productColor,
                    secondTextColor: productColor,
                    onClick: groupTypeId == "GROUP"
                        ? () {
                            selectTier();
                          }
                        : () {},
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Эхлэх огноо',
                    secondText: DateFormat('yyyy-MM-dd').format(startDate),
                    arrowColor: productColor,
                    secondTextColor: productColor,
                    onClick: () {
                      changeStartDate();
                    },
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Дуусах огноо',
                    secondText: DateFormat('yyyy-MM-dd').format(endDate),
                    arrowColor: productColor,
                    secondTextColor: productColor,
                    onClick: () {
                      changeEndDate();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Тохиргоонд хамаарах харилцагчид',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: grey2,
                      ),
                    ),
                  ),
                  Column(
                    children: widget.list
                        .map(
                          (data) => PriceSettingCard(data: data),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomButton(
                          isLoading: isSubmit,
                          borderColor: productColor,
                          labelText: 'Хадгалах',
                          labelColor: backgroundColor,
                          textColor: productColor,
                          onClick: () {
                            validateCheck(false);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          isLoading: isSubmit,
                          labelColor: productColor,
                          labelText: 'Батлах',
                          onClick: () {
                            validateCheck(true);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }

  selectGroupType() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: general.priceGroupTypes!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          groupType = e.name;
                          groupTypeId = e.code;
                          groupTypeValidate = false;
                          tier = null;
                          tierNo = null;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  selectPriceGroup() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: group.rows!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          priceGroup = e.name;
                          priceGroupId = e.id;
                          priceGroupValidate = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  selectTier() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tiers
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          tier = e.name;
                          tierNo = e.tierNo;
                          tierValidate = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          "${e.name}",
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  changeStartDate() {
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
                onPressed: () async {
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
                  initialDateTime: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(DateTime.now())),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      startDate = newDate;
                    });
                    if (startDate.difference(endDate).inDays > 0) {
                      setState(() {
                        endDate = startDate;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  changeEndDate() {
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
                onPressed: () async {
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
                  initialDateTime:
                      DateTime.parse(DateFormat('yyyy-MM-dd').format(endDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      endDate = newDate;
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
