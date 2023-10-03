import 'dart:io';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  bool isFileEmpty = false;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        setState(() {
          isFileEmpty = false;
        });
        print("File name $fileName");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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
            children: [
              SizedBox(
                height: 5,
              ),
              FormTextField(
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
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: FormTextField(
                  textAlign: TextAlign.left,
                  name: 'additional',
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  pickFile();
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
              if (pickedFile != null)
                // Container(
                //   height: 300,
                //   width: 300,
                //   child: Image.file(fileToDisplay!),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  color: white,
                  child: Text('${fileName}'),
                ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 70, right: 15, left: 15),
            child: CustomButton(
              isGradient: true,
              gradient: gradient,
              onClick: () {
                try {
                  if (result != null) {
                    widget.pickedFile.filPickerChange(result);
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      isFileEmpty = true;
                    });
                  }
                } catch (e) {
                  print(e);
                }
              },
              labelText: "Болсон. Нэмье",
            ),
          )
        ],
      ),
    );
  }
}
