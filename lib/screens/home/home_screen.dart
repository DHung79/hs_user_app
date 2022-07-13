import 'package:flutter/material.dart';
import '/main.dart';
import '../../core/user/model/user_model.dart';
import 'components/booking_content/booking_content.dart';
import 'components/home_content/home_content.dart';
import 'components/setting_content/setting_content.dart';

class HomeScreen extends StatefulWidget {
  final int homeTab;
  final int bookingTab;
  const HomeScreen({
    Key? key,
    this.homeTab = 0,
    this.bookingTab = 0,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool backHome = true;
  final PageState _pageState = PageState();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
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
            child: snapshot.hasData
                ? buildContent(snapshot.data!)
                : const SizedBox(),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Widget buildContent(UserModel user) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _getContent(user),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navigaButton(
                icon: SvgIcons.home1,
                name: 'Trang chủ',
                activeColor: AppColor.primary1,
                isActive: widget.homeTab == 0,
                paddingActiveColor: AppColor.shade3,
                onPressed: () {
                  navigateTo(homeRoute);
                },
              ),
              navigaButton(
                icon: SvgIcons.dailyTask,
                name: 'Đặt lịch',
                activeColor: AppColor.primary2,
                isActive: widget.homeTab == 1,
                paddingActiveColor: AppColor.shade4,
                onPressed: () {
                  navigateTo(bookingRoute);
                },
              ),
              navigaButton(
                icon: SvgIcons.user1,
                name: 'Cài đặt',
                activeColor: AppColor.shade6,
                isActive: widget.homeTab == 2,
                paddingActiveColor: AppColor.shade10,
                onPressed: () {
                  navigateTo(settingRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigaButton({
    required void Function()? onPressed,
    required SvgIconData icon,
    required String name,
    required bool isActive,
    required Color activeColor,
    required Color paddingActiveColor,
  }) {
    final _color = isActive ? activeColor : AppColor.text3;
    final _colorText = isActive ? activeColor : AppColor.text7;

    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        primary: Colors.white,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width / 3 - 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isActive ? paddingActiveColor : Colors.transparent,
            ),
            child: SvgIcon(
              icon,
              size: 24,
              color: _color,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: AppTextTheme.subText(_colorText),
          )
        ],
      ),
    );
  }

  Widget _getContent(UserModel user) {
    if (widget.homeTab == 1) {
      return BookingContent(tab: widget.bookingTab);
    } else if (widget.homeTab == 2) {
      return const SettingContent();
    } else {
      return const HomeContent();
    }
  }

  _fetchDataOnPage() {}
}
