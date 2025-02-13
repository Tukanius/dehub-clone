import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/entry_point/first_page/first_page.dart';
import 'package:dehub/src/entry_point/menu/menu_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  static const routeName = '/EntryPoint';
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.75).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onPanUpdate: (details) {
          onPanUpdate(details);
        },
        child: Scaffold(
          backgroundColor: menuBack,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                height: MediaQuery.of(context).size.height,
                left: isSideMenuClosed ? -288 * animation.value : 0,
                width: MediaQuery.of(context).size.width * 0.75,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    onPanUpdate(details);
                  },
                  child: const MenuPage(),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(animation.value - 30 * animation.value * pi / 180),
                child: Transform.translate(
                  offset: Offset(
                    animation.value * MediaQuery.of(context).size.width * 0.75,
                    0,
                  ),
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24 * animation.value),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          onPanUpdate(details);
                        },
                        onTap: () {
                          setState(() {
                            isSideMenuClosed = true;
                            animationController.reverse();
                          });
                        },
                        child: FirstPage(
                          isSideMenuClosed: isSideMenuClosed,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                left: isSideMenuClosed ? 0 : 220,
                top: MediaQuery.of(context).size.height /
                        MediaQuery.of(context).size.width +
                    15,
                curve: Curves.ease,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSideMenuClosed) {
                        animationController.forward();
                      } else {
                        animationController.reverse();
                      }
                      isSideMenuClosed = !isSideMenuClosed;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.only(left: 15, top: 40),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSideMenuClosed ? white : buttonColor,
                    ),
                    child: isSideMenuClosed
                        ? SvgPicture.asset(
                            'assets/svg/menu.svg',
                            colorFilter: const ColorFilter.mode(
                                buttonColor, BlendMode.srcIn),
                          )
                        : const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: white,
                              size: 14,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx < 0) {
      setState(() {
        isSideMenuClosed = true;
        animationController.reverse();
      });
    } else {
      setState(() {
        isSideMenuClosed = false;
        animationController.forward();
      });
    }
  }
}
