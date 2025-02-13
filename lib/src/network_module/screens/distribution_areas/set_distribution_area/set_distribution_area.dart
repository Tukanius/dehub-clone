import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/distribution_areas.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/network_module/screens/direction_page/add_direction.dart';
import 'package:dehub/src/network_module/screens/zoning_page/add_zoning.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SetDistributionAreaArguments {
  String id;
  ListenController listenController;
  SetDistributionAreaArguments({
    required this.listenController,
    required this.id,
  });
}

class SetDistributionArea extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/SetDistributionArea';
  const SetDistributionArea({
    super.key,
    required this.id,
    required this.listenController,
  });

  @override
  State<SetDistributionArea> createState() => _SetDistributionAreaState();
}

class _SetDistributionAreaState extends State<SetDistributionArea> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? distributionArea;
  String? coClientStaff;
  String? areaRegionId;
  String? areaRefCode;
  String? coClientStaffId;
  General general = General();
  List<DistributionAreas> parentList = [];

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await BusinessApi().setDistributionArea(
        BusinessNetwork(
          businessIds: [widget.id],
          areaRegionId: areaRegionId,
          areaDirectionId: coClientStaffId,
          areaDesc: textController.text,
        ),
      );
      widget.listenController.changeVariable('SetDistributionArea');
      loading.loading(false);
      showCustomDialog(
        context,
        "Амжилттай хадгаллаа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  dArea(bool isParent) {
    if (isParent == true) {
      parentList = general.distributionAreas!
          .where((element) => element.isParent == true)
          .toList();
    } else {
      parentList = general.distributionAreas!
          .where((element) => element.isParent == false)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        title: const Text(
          'Чиглэл, бүсчлэл тохируулах',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          CustomCloseButton(
            color: networkColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Бүсийн нэр",
              onClick: () {
                dArea(true);
                show();
              },
              arrowColor: networkColor,
              secondText: distributionArea,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Чиглэлийн нэр",
              onClick: distributionArea != null
                  ? () {
                      dArea(false);
                      area();
                    }
                  : () {},
              arrowColor: networkColor,
              secondText: coClientStaff,
              secondTextColor: networkColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: const Text(
                'Тайлбар',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: grey3,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.all(15),
              child: FormBuilder(
                key: fbKey,
                child: FormTextField(
                  controller: textController,
                  textAlign: TextAlign.left,
                  name: 'description',
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Энд оруулна уу',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: grey),
                    ),
                    fillColor: white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: grey2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              labelText: "Хадгалах",
              labelColor: distributionArea == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              onClick: () {
                distributionArea == null ? () {} : onSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  show() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Бүс сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                parentList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: parentList
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    distributionArea = e.name;
                                    areaRegionId = e.id;
                                    areaRefCode = e.refCode;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    color: transparent,
                                    child: Text(
                                      '${e.name}',
                                      style: TextStyle(
                                        color: black.withOpacity(0.7),
                                      ),
                                    )),
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: [
                          const NotFound(
                            module: "NETWORK",
                            labelText: '',
                          ),
                          CustomButton(
                            onClick: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                AddZoning.routeName,
                                arguments: AddZoningArguments(
                                  listenController: ListenController(),
                                ),
                              );
                            },
                            labelColor: networkColor,
                            labelText: 'Бүсчлэл нэмэх',
                          )
                        ],
                      ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  area() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Чиглэл сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                parentList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: parentList
                            .where(
                                (element) => element.parentId == areaRegionId)
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    coClientStaff = "${e.name}";
                                    coClientStaffId = e.id.toString();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: transparent,
                                  child: Text(
                                    '${e.name}',
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: [
                          const NotFound(
                            module: "NETWORK",
                            labelText: '',
                          ),
                          CustomButton(
                            onClick: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                AddDirection.routeName,
                                arguments: AddDirectionArguments(
                                  listenController: ListenController(),
                                  parentId: areaRegionId,
                                  parentName: distributionArea,
                                  parentRefCode: areaRefCode,
                                ),
                              );
                            },
                            labelColor: networkColor,
                            labelText: 'Чиглэл нэмэх',
                          )
                        ],
                      ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
