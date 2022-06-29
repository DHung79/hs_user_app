import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/screens/layout_template/content_screen.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import '../../core/user/model/user_model.dart';
import '../home/booking_screen/booking_screen.dart';
import '../home/home_content_screen/home_content_screen.dart';
import '../home/setting_screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool backHome = true;
  final PageState _pageState = PageState();
  final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const Booking(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      homePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          backHome = !backHome;
        });
        return backHome;
      },
      child: PageTemplate(
        pageState: _pageState,
        onUserFetched: (user) => setState(() {}),
        onFetch: () {
          _fetchDataOnPage();
        },
        appBarHeight: 0,
        child: FutureBuilder(
          future: _pageState.currentUser,
          builder: (context, AsyncSnapshot<UserModel> snapshot) {
            return PageContent(
              child: content(), // child: content(context),
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage();
              },
            );
          },
        ),
      ),
    );
  }

  Scaffold content() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(homePageIndex),
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
                          top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: SvgIcon(
                        SvgIcons.home1,
                        color: AppColor.text3,
                        size: 24,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    label: 'Trang chủ',
                    activeIcon: Container(
                      child: SvgIcon(
                        SvgIcons.home1,
                        color: AppColor.primary1,
                        size: 24,
                      ),
                      padding: const EdgeInsets.only(
                          top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                      decoration: BoxDecoration(
                          color: AppColor.shade3,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 8),
                    )),
                BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.only(
                          top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: SvgIcon(
                        SvgIcons.dailyTask,
                        color: AppColor.text3,
                        size: 24,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    label: 'Đặt lịch',
                    activeIcon: Container(
                      child: SvgIcon(
                        SvgIcons.dailyTask,
                        color: AppColor.primary2,
                        size: 24,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: SvgIcon(
                        SvgIcons.user1,
                        color: AppColor.text3,
                        size: 24,
                      ),
                    ),
                    backgroundColor: AppColor.shade10,
                    label: 'Cài đặt',
                    activeIcon: Container(
                      child: SvgIcon(
                        SvgIcons.user1,
                        color: AppColor.shade6,
                        size: 24,
                      ),
                      padding: const EdgeInsets.only(
                          top: 14.25, bottom: 14.25, left: 41.67, right: 41.67),
                      decoration: BoxDecoration(
                          color: AppColor.shade10,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 8),
                    )),
              ],
              currentIndex: homePageIndex,
              selectedItemColor: homePageIndex == 0
                  ? AppColor.primary1
                  : homePageIndex == 1
                      ? AppColor.primary2
                      : const Color.fromRGBO(0, 139, 203, 1),
              onTap: _onItemTapped,
              // selectedFontSize: 12,
              // selectedLabelStyle: FontStyle().selectFontNav,
              // unselectedLabelStyle: FontStyle().unselectFontNav,
            )),
      ),
    );
  }
}

void _fetchDataOnPage() {}
