import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class PictureForm extends StatefulWidget {
  final GlobalKey? profileKey;
  const PictureForm({super.key, this.profileKey});

  @override
  State<PictureForm> createState() => _PictureFormState();
}

class _PictureFormState extends State<PictureForm> {
  final picker = ImagePicker();
  bool isLoading = false;
  InventoryGoods user = InventoryGoods();
  InventoryGoods banner = InventoryGoods();
  XFile? bannerImage;
  final ImagePicker imagePicker = ImagePicker();

  getImage(ImageSource imageSource, bool isProfile) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (file != null) {
      if (isProfile == true) {
        setState(() {
          isLoading = true;
        });
        user = await InventoryApi().upload(file);
        source.profileImage(user.url.toString());
        setState(() {
          source.profileValidate = false;
          isLoading = false;
        });
      } else {
        banner = await InventoryApi().upload(bannerImage!);
        Provider.of<InventoryProvider>(context, listen: false)
            .bannerImages(banner.url.toString());
      }
    }
  }

  void getMultiplyImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      for (var i = 0; i < selectedImages.length; i++) {
        banner = await InventoryApi().upload(selectedImages[i]);
        Provider.of<InventoryProvider>(context, listen: false)
            .bannerImages(banner.url.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Нүүрэнд гарах зураг',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          key: widget.profileKey,
          padding: const EdgeInsets.all(15),
          color: white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: source.profileValidate == false
                        ? Color(0xffD9D9D9)
                        : red,
                  ),
                  color: Color(0xffFAFAFA),
                ),
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(color: grey3),
                      )
                    : source.product.url == null
                        ? Center(
                            child: Icon(
                            Icons.add,
                            color:
                                source.profileValidate == false ? grey3 : red,
                            size: 11,
                          ))
                        : Image.network(
                            '${source.product.url}',
                            fit: BoxFit.cover,
                          ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: source.profileValidate == false
                            ? Color(0xffD9D9D9)
                            : red,
                      ),
                      color: Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(color: grey3),
                          )
                        : source.product.url == null
                            ? Center(
                                child: Icon(
                                Icons.add,
                                color: source.profileValidate == false
                                    ? grey3
                                    : red,
                                size: 11,
                              ))
                            : Image.network(
                                '${source.product.url}',
                                fit: BoxFit.cover,
                              ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: source.profileValidate == false
                            ? Color(0xffD9D9D9)
                            : red,
                      ),
                      color: Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(color: grey3),
                          )
                        : source.product.url == null
                            ? Center(
                                child: Icon(
                                  Icons.add,
                                  color: source.profileValidate == false
                                      ? grey3
                                      : red,
                                  size: 11,
                                ),
                              )
                            : Image.network(
                                '${source.product.url}',
                                fit: BoxFit.cover,
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery, true);
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 7.5, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset('assets/svg/image_upload.svg'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera, true);
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    right: 15, left: 7.5, bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset('assets/svg/camera_plus.svg'),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Баннерт гарах зураг',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: white,
          child: Container(
            height: 130,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              children: source.product.detailImages != null &&
                      source.product.detailImages?.length != 0
                  ? source.product.detailImages!
                      .map(
                        (data) => Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: data != 3 ? 7 : 0),
                              height: 130,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xffD9D9D9),
                                ),
                                color: Color(0xffFAFAFA),
                              ),
                              child: Image.network(
                                '${data}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 10,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: white),
                                child: GestureDetector(
                                  onTap: () {
                                    source.removeBannerImage(source
                                        .product.detailImages!
                                        .indexOf(data));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg/close.svg',
                                    colorFilter: ColorFilter.mode(
                                        productColor, BlendMode.srcIn),
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList()
                  : [1, 2]
                      .map(
                        (data) => Container(
                          margin: EdgeInsets.only(right: data != 2 ? 7 : 0),
                          height: 130,
                          width: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: source.bannerValidate == true
                                  ? red
                                  : Color(0xffD9D9D9),
                            ),
                            color: Color(0xffFAFAFA),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color:
                                  source.bannerValidate == true ? red : grey3,
                              size: 11,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getMultiplyImage();
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 7.5, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset('assets/svg/image_upload.svg'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera, false);
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    right: 15, left: 7.5, bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset('assets/svg/camera_plus.svg'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}