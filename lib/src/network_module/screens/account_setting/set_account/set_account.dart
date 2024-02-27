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
import 'package:dehub/src/payment_module/screens/link_account_page/link_account_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SetAccountArguments {
  String id;
  ListenController listenController;
  SetAccountArguments({
    required this.listenController,
    required this.id,
  });
}

class SetAccount extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/SetAccount';
  const SetAccount({
    super.key,
    required this.id,
    required this.listenController,
  });

  @override
  State<SetAccount> createState() => _SetAccountState();
}

class _SetAccountState extends State<SetAccount> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? inAccName;
  String? outAccName;
  String? inAccId;
  String? outAccId;
  General general = General();

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await BusinessApi().setAccount(
        BusinessNetwork(
          businessIds: [widget.id],
          inAccId: inAccId,
          outAccId: outAccId,
        ),
      );
      loading.loading(false);
      showCustomDialog(
        context,
        "Амжилттай хадгаллаа",
        true,
        onPressed: () {
          widget.listenController.changeVariable('SetAccount');
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
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
          'Данс тохируулах',
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
              labelText: "Орлого авах данс",
              onClick: () {
                inAcc();
              },
              arrowColor: networkColor,
              secondText: inAccName ?? '-',
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Зарлага гаргах данс",
              onClick: () {
                outAcc();
              },
              arrowColor: networkColor,
              secondText: outAccName ?? '-',
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
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              labelText: "Хадгалах",
              labelColor: inAccName == null || outAccName == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              onClick: () {
                inAccName == null || outAccName == null ? () {} : onSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  inAcc() {
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Орлогын данс сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                general.bankAccounts!.isNotEmpty
                    ? Column(
                        children: general.bankAccounts!
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    inAccName = "${e.bankName} ${e.number}";
                                    inAccId = e.id.toString();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: transparent,
                                  child: Row(
                                    children: [
                                      e.icon == null
                                          ? const CircleAvatar(
                                              radius: 12,
                                              backgroundImage:
                                                  AssetImage('images/map.jpg'),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: grey2,
                                              radius: 12,
                                              backgroundImage:
                                                  NetworkImage('${e.icon}'),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${e.bankName} ${e.number}',
                                        style: TextStyle(
                                          color: black.withOpacity(0.7),
                                        ),
                                      )
                                    ],
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
                              Navigator.of(context)
                                  .pushNamed(LinkAccountPage.routeName);
                            },
                            labelColor: networkColor,
                            labelText: 'Данс нэмэх',
                          ),
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

  outAcc() {
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Зарлагын данс сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                general.bankAccounts!.isNotEmpty
                    ? Column(
                        children: general.bankAccounts!
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    outAccName = "${e.bankName} ${e.number}";
                                    outAccId = e.id.toString();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: transparent,
                                  child: Row(
                                    children: [
                                      e.icon == null
                                          ? const CircleAvatar(
                                              radius: 12,
                                              backgroundImage:
                                                  AssetImage('images/map.jpg'),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: grey2,
                                              radius: 12,
                                              backgroundImage:
                                                  NetworkImage('${e.icon}'),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${e.bankName} ${e.number}',
                                        style: TextStyle(
                                          color: black.withOpacity(0.7),
                                        ),
                                      )
                                    ],
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
                              Navigator.of(context)
                                  .pushNamed(LinkAccountPage.routeName);
                            },
                            labelColor: networkColor,
                            labelText: 'Данс нэмэх',
                          ),
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
