import 'dart:async';
import 'dart:io';
import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/auth/camera_page/camera_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddAttachmentArguments {
  ListenController pickedFile;
  AddAttachmentArguments({
    required this.pickedFile,
  });
}

class AddAttachment extends StatefulWidget {
  final ListenController pickedFile;
  static const routeName = '/AddAttachment';
  const AddAttachment({
    super.key,
    required this.pickedFile,
  });

  @override
  State<AddAttachment> createState() => _AddAttachmentState();
}

class _AddAttachmentState extends State<AddAttachment> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  FilePickerResult? file;
  User user = User();
  String? fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  bool isFileEmpty = false;
  final picker = ImagePicker();
  File? image;
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  ListenController listenController = ListenController();

  void pickFile() async {
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
        user = await AuthApi().uploadFile(pickedFile!, 'order');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);

    if (file != null) {
      setState(() {
        image = File(file.path);
        fileName = file.path;
        isLoading = true;
      });
      setState(() {
        isFileEmpty = false;
      });
      user = await OrderApi().upload(file.path);
      setState(() {
        isLoading = false;
      });
    }
  }

  onSubmit() {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        if (user.url != null) {
          widget.pickedFile.filPickerChange(
            Order(
              url: user.url.toString(),
              description: controller.text,
              name: nameController.text,
            ),
          );
          Navigator.of(context).pop();
        } else {
          setState(() {
            isFileEmpty = true;
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoActionSheet(
            title: Column(
              children: [
                Text(
                  'Файл хавсаргах',
                  style: TextStyle(
                    color: black.withOpacity(0.6),
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Тус бүр 3MB-с хэтрэхгүй 3 файл зөвшөөрнө',
                  style: TextStyle(
                    color: black.withOpacity(0.6),
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              CupertinoActionSheetAction(
                child: const Text(
                  'Файлын сангаас',
                  style: TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  pickFile();
                },
              ),
              CupertinoActionSheetAction(
                child: const Text(
                  'Зургийн сангаас',
                  style: TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.gallery);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text(
                  'Зураг авах',
                  style: TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  camera();
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: const Center(
                child: Text(
                  "Буцах",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: grey2,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  camera() {
    Navigator.of(context).pushNamed(
      CameraPage.routeName,
      arguments: CameraPageArguments(listenController: listenController),
    );
  }

  @override
  void initState() {
    listenController.addListener(() async {
      user = await UserApi().upload(listenController.value!);
      setState(() {
        fileName = listenController.value!;
      });
    });
    super.initState();
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
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: orderColor),
          title: const Text(
            'Файлын нэр',
            style: TextStyle(
              color: buttonColor,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                FormBuilder(
                  key: fbKey,
                  child: Column(
                    children: [
                      FormTextField(
                        controller: nameController,
                        textColor: orderColor,
                        textAlign: TextAlign.end,
                        name: 'name',
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: orderColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Нэр',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Нэр оруулна уу'),
                        ]),
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
                            ),
                            fillColor: white,
                            filled: true,
                            hintStyle: TextStyle(
                              color: orderColor,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Тайлбар оруулна уу'),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showOptions();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Файл сонгох',
                          style: TextStyle(color: buttonColor),
                        ),
                        Row(
                          children: [
                            Text(
                              'Сонгох',
                              style: TextStyle(
                                color: orderColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: orderColor,
                              size: 14,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (isFileEmpty == true)
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Файл сонгоно уу',
                        style: TextStyle(color: red),
                      ),
                    ],
                  ),
                if (user.url != null) Text('$fileName')
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 70, right: 15, left: 15),
              child: CustomButton(
                labelColor: orderColor,
                onClick: onSubmit,
                labelText: "Болсон. Нэмье",
              ),
            )
          ],
        ),
      ),
    );
  }
}
