import 'dart:io';
import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
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
    Key? key,
    required this.pickedFile,
  }) : super(key: key);

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
        user = await AuthApi().uploadFile(pickedFile!);
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
      user = await AuthApi().upload(file);
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
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
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
                  child: Text(
                    'Файлын сангаас',
                    style:
                        TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pickFile();
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'Зургийн сангаас',
                    style:
                        TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.gallery);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'Зураг авах',
                    style:
                        TextStyle(color: orderColor, fontFamily: 'Montserrat'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.camera);
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Center(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: Text(
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
              SizedBox(
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
                      decoration: InputDecoration(
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
                          children: const [
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
                        decoration: InputDecoration(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
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
              isFileEmpty == true
                  ? Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Файл сонгоно уу',
                          style: TextStyle(color: red),
                        ),
                      ],
                    )
                  : SizedBox(),
              if (user.url != null) Text('$fileName')
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 70, right: 15, left: 15),
            child: CustomButton(
              isGradient: true,
              gradient: gradient,
              onClick: onSubmit,
              labelText: "Болсон. Нэмье",
            ),
          )
        ],
      ),
    );
  }
}
