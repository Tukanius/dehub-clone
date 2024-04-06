import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullPictureArguments {
  List pictures;
  int initialPage;
  FullPictureArguments({
    required this.pictures,
    required this.initialPage,
  });
}

class FullPicture extends StatefulWidget {
  static const routeName = '/FullPicture';
  final List pictures;
  final int initialPage;
  const FullPicture({
    super.key,
    required this.initialPage,
    required this.pictures,
  });

  @override
  State<FullPicture> createState() => _FullPictureState();
}

class _FullPictureState extends State<FullPicture> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialPage);
    setState(() {
      currentIndex = widget.initialPage;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black.withOpacity(0.1),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: widget.pictures
                  .map(
                    (e) => InteractiveViewer(
                      minScale: 1,
                      maxScale: 2,
                      panEnabled: false,
                      boundaryMargin: const EdgeInsets.all(100),
                      child: Dismissible(
                        key: GlobalKey(),
                        direction: DismissDirection.vertical,
                        onDismissed: (direction) {
                          Navigator.of(context).pop();
                        },
                        child: Image.network(e, fit: BoxFit.contain),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/close.svg',
                      colorFilter:
                          const ColorFilter.mode(transparent, BlendMode.srcIn),
                    ),
                    Text(
                      '${currentIndex + 1} / ${widget.pictures.length}',
                      style: const TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const CustomCloseButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
