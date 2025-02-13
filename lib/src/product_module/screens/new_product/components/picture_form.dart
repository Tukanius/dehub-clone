import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/auth/camera_page/camera_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductPictureForm extends StatefulWidget {
  final GlobalKey? profileKey;
  const ProductPictureForm({super.key, this.profileKey});

  @override
  State<ProductPictureForm> createState() => _ProductPictureFormState();
}

class _ProductPictureFormState extends State<ProductPictureForm> {
  final picker = ImagePicker();
  bool isLoading = false;
  InventoryGoods user = InventoryGoods();
  InventoryGoods banner = InventoryGoods();
  XFile? bannerImage;
  final ImagePicker imagePicker = ImagePicker();
  ListenController listenController = ListenController();

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (file != null) {
      setState(() {
        isLoading = true;
      });
      user = await InventoryApi().upload(file.path);
      source.profileImage(user.url.toString());
      setState(() {
        source.profileValidate = false;
        isLoading = false;
      });
    }
  }

  void getMultiplyImage() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (var i = 0; i < selectedImages.length; i++) {
        banner = await InventoryApi().upload(selectedImages[i].path);
        Provider.of<InventoryProvider>(context, listen: false)
            .bannerImages(banner.url.toString());
      }
    }
  }

  @override
  void initState() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    listenController.addListener(() async {
      user = await InventoryApi().upload(listenController.value!);
      source.profileImage(user.url!);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
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
                        ? const Color(0xffD9D9D9)
                        : red,
                  ),
                  color: const Color(0xffFAFAFA),
                ),
                child: isLoading == true
                    ? const Center(
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
              const SizedBox(
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
                            ? const Color(0xffD9D9D9)
                            : red,
                      ),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? const Center(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: source.profileValidate == false
                            ? const Color(0xffD9D9D9)
                            : red,
                      ),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? const Center(
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
                getImage(ImageSource.gallery);
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
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/image_upload.svg',
                    colorFilter:
                        const ColorFilter.mode(productColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CameraPage.routeName,
                  arguments:
                      CameraPageArguments(listenController: listenController),
                );
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
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/camera_plus.svg',
                    colorFilter:
                        const ColorFilter.mode(productColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
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
          child: SizedBox(
            height: 130,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              children: source.product.detailImages != null &&
                      source.product.detailImages!.isNotEmpty
                  ? source.product.detailImages!
                      .map(
                        (data) => Stack(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(right: data != "3" ? 7 : 0),
                              height: 130,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: const Color(0xffD9D9D9),
                                ),
                                color: const Color(0xffFAFAFA),
                              ),
                              child: Image.network(
                                data,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 10,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: white),
                                child: GestureDetector(
                                  onTap: () {
                                    source.removeBannerImage(source
                                        .product.detailImages!
                                        .indexOf(data));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg/close.svg',
                                    colorFilter: const ColorFilter.mode(
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
                                  : const Color(0xffD9D9D9),
                            ),
                            color: const Color(0xffFAFAFA),
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
        const SizedBox(
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
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/image_upload.svg',
                    colorFilter:
                        const ColorFilter.mode(productColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
