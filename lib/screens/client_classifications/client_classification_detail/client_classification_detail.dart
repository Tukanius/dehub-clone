import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/screens/client_classifications/set_client_classification/set_client_classification.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientClassificationDetailArguments {
  String id;
  ClientClassificationDetailArguments({
    required this.id,
  });
}

class ClientClassificationDetail extends StatefulWidget {
  final String id;
  static const routeName = '/ClientClassificationDetail';
  const ClientClassificationDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ClientClassificationDetail> createState() =>
      _ClientClassificationDetailState();
}

class _ClientClassificationDetailState extends State<ClientClassificationDetail>
    with AfterLayoutMixin {
  bool isLoading = true;
  BusinessNetwork get = BusinessNetwork();
  TextEditingController controller = TextEditingController();
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    get = await BusinessApi().networkGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      get = await BusinessApi().networkGet(widget.id);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: CustomBackButton(color: networkColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, bottom: 10, top: 25),
              child: Text(
                'Харилцагчийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Партнерийн нэр",
              secondText: get.partnerName,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Партнер код",
              secondText: get.partner?.refCode,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Бизнесийн нэр",
              secondText: get.profileName,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Бизнес код",
              secondText: get.refCode,
              secondTextColor: networkColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
              child: Text(
                'Мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Ангилал",
              secondText: get.classificationCategory?.name,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Зэрэглэл",
              secondText: get.classificationPriority?.name,
              secondTextColor: networkColor,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  SetClientClassification.routeName,
                  arguments: SetClientClassificationArguments(
                    listenController: listenController,
                    id: widget.id,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.5),
                color: transparent,
                padding: const EdgeInsets.only(right: 15, top: 10, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset('assets/svg/person-check.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Өөрчлөх',
                      style: TextStyle(
                        color: networkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text(
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
                readOnly: true,
                controller: controller,
                textAlign: TextAlign.left,
                name: 'description',
                maxLines: 5,
                decoration: InputDecoration(
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
          ],
        ),
      ),
    );
  }
}
