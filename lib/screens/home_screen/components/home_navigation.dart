import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/config/theme.dart';

class HomeNavigation extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomeNavigation({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
        boxShadow: kElevationToShadow[4],
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      'assets/icons/17076.svg',
                      width: 20,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  label: 'Trang chủ',
                  activeIcon: Container(
                    child: SvgPicture.asset(
                      'assets/icons/17076.svg',
                      width: 20,
                      color: ColorApp.purpleColor,
                    ),
                    // color: ColorApp.purpleColor,
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration: BoxDecoration(
                        color: ColorApp.bgNav,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                  )),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      'assets/icons/27704.svg',
                      width: 20,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  label: 'Đặt lịch',
                  activeIcon: Container(
                    child: SvgPicture.asset(
                      'assets/icons/27704.svg',
                      width: 20,
                      color: ColorApp.orangeColor,
                    ),
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 245, 232, 1),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                  )),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      'assets/icons/17090.svg',
                      width: 20,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  label: 'Cài đặt',
                  activeIcon: Container(
                    child: SvgPicture.asset(
                      'assets/icons/17090.svg',
                      width: 20,
                      color: const Color.fromRGBO(0, 139, 203, 1),
                    ),
                    padding: const EdgeInsets.only(
                        top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(238, 252, 250, 1),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                  )),
            ],
            currentIndex: widget.currentIndex,
            selectedItemColor: widget.currentIndex == 0
                ? ColorApp.purpleColor
                : widget.currentIndex == 1
                    ? ColorApp.orangeColor
                    : const Color.fromRGBO(0, 139, 203, 1),
            onTap: widget.onTap,
            // selectedFontSize: 12,
            // selectedLabelStyle: FontStyle().selectFontNav,
            // unselectedLabelStyle: FontStyle().unselectFontNav,
          )),
    );
  }
}
