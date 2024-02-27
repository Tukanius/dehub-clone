import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/network_module/screens/category_page/add_category.dart';
import 'package:dehub/src/network_module/screens/rank_page/add_rank.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/client_classification.dart';

class SetClientClassificationArguments {
  String id;
  ListenController listenController;
  SetClientClassificationArguments({
    required this.listenController,
    required this.id,
  });
}

class SetClientClassification extends StatefulWidget {
  final ListenController listenController;
  final String id;
  static const routeName = '/SetClientClassification';
  const SetClientClassification({
    super.key,
    required this.id,
    required this.listenController,
  });

  @override
  State<SetClientClassification> createState() =>
      _SetClientClassificationState();
}

class _SetClientClassificationState extends State<SetClientClassification> {
  TextEditingController controller = TextEditingController();
  General general = General();
  String? className;
  String? classId;
  String? classRefCode;
  String? rankName;
  String? rankId;
  List<ClientClassifications>? classList = [];

  list(bool isParent) {
    if (isParent == true) {
      classList = general.clientClassifications!
          .where((element) => element.parentId == null)
          .toList();
    } else {
      classList = general.clientClassifications!
          .where((element) => element.parentId == classId)
          .toList();
    }
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (classId != null || rankId != null) {
      try {
        loading.loading(true);
        await BusinessApi().setClientClassification(
          BusinessNetwork(
            businessIds: [widget.id],
            classificationCategoryId: classId,
            classificationPriorityId: rankId,
            classificationDesc: controller.text,
          ),
        );
        loading.loading(false);
        showCustomDialog(
          context,
          "Амжилттай хадгаллааа",
          true,
          onPressed: () {
            Navigator.of(context).pop();
            widget.listenController.changeVariable('SetClassification');
          },
        );
      } catch (e) {
        loading.loading(false);
      }
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
          'Ангилал, зэрэглэл тохируулах',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          CustomCloseButton(),
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
              onClick: () {
                list(true);
                classification();
              },
              labelText: 'Ангилал',
              secondText: className,
              arrowColor: networkColor,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              onClick: className != null
                  ? () {
                      list(false);
                      rank();
                    }
                  : () {},
              labelText: 'Зэрэглэл',
              secondText: rankName,
              arrowColor: networkColor,
              secondTextColor: networkColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: const Text(
                'Тайлбар',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.all(15),
              child: FormTextField(
                controller: controller,
                textAlign: TextAlign.left,
                name: 'description',
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  fillColor: white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: grey2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              textColor: white,
              labelText: 'Хадгалах',
              labelColor: classId == null || rankId == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              onClick: () {
                onSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  classification() {
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
                    'Ангилал',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                classList!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: classList!
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    className = e.name;
                                    classRefCode = e.refCode;
                                    classId = e.id;
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
                                AddCategory.routeName,
                                arguments: AddCategoryArguments(
                                  listenController: ListenController(),
                                ),
                              );
                            },
                            labelColor: networkColor,
                            labelText: 'Ангилал нэмэх',
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

  rank() {
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
                    'Зэрэглэл',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                classList!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: classList!
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rankName = e.name;
                                    rankId = e.id;
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
                                AddRank.routeName,
                                arguments: AddRankArguments(
                                  parentId: classId,
                                  parentRefCode: classRefCode,
                                  parentName: className,
                                  listenController: ListenController(),
                                ),
                              );
                            },
                            labelColor: networkColor,
                            labelText: 'Зэрэглэл нэмэх',
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
