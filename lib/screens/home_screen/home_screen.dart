import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/config/theme.dart';
import 'booking/booking.dart';
import 'components/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const Booking(),
    const Text('Admin')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            // color: Colors.white,
            padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
              boxShadow: kElevationToShadow[4],
            ),
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: const EdgeInsets.only(
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              color: ColorApp.bgNav,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 8),
                        )),
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: const EdgeInsets.only(
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 245, 232, 1),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 8),
                        )),
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: const EdgeInsets.only(
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                              top: 14.25,
                              bottom: 14.25,
                              left: 41.67,
                              right: 41.67),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(238, 252, 250, 1),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 8),
                        )),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: _selectedIndex == 0
                      ? ColorApp.purpleColor
                      : _selectedIndex == 1
                          ? ColorApp.orangeColor
                          : const Color.fromRGBO(0, 139, 203, 1),
                  onTap: _onItemTapped,
                  // selectedFontSize: 12,
                  // selectedLabelStyle: FontStyle().selectFontNav,
                  // unselectedLabelStyle: FontStyle().unselectFontNav,
                )),
          ),
        ),
      ),
    );
  }
}
