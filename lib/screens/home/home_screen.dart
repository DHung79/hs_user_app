import 'package:flutter/material.dart';
import '../../core/notification/notification.dart';
import '/main.dart';
import '../../core/user/model/user_model.dart';
import 'components/booking_content/book_task_content.dart';
import 'components/home_content/home_content.dart';
import 'components/setting_content/setting_content.dart';

class HomeScreen extends StatefulWidget {
  final int homeTab;
  final int bookingTab;
  final int settingTab;
  const HomeScreen({
    Key? key,
    this.homeTab = 0,
    this.bookingTab = 0,
    this.settingTab = 0,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool backHome = true;
  final PageState _pageState = PageState();
  late UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {
        userModel = user;
      }),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: snapshot.hasData
                ? buildContent(userModel != null ? userModel! : snapshot.data!)
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _getContent(user),
        ),
        if (widget.settingTab == 0)
          Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.shadow.withOpacity(0.32),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 8,
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navigaButton(
                  icon: SvgIcons.home1,
                  name: 'Trang chủ',
                  activeColor: AppColor.primary1,
                  isActive: widget.homeTab == 0,
                  paddingActiveColor: AppColor.shade3,
                  onPressed: () {
                    navigateTo(homeRoute);
                  },
                ),
                _navigaButton(
                  icon: SvgIcons.clipboardCheck,
                  name: 'Đặt lịch',
                  activeColor: AppColor.primary2,
                  isActive: widget.homeTab == 1,
                  paddingActiveColor: AppColor.shade4,
                  onPressed: () {
                    navigateTo(bookTaskRoute);
                  },
                ),
                _navigaButton(
                  icon: SvgIcons.user,
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
      ],
    );
  }

  Widget _navigaButton({
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
      return BookingContent(
        tab: widget.bookingTab,
        user: user,
      );
    } else if (widget.homeTab == 2) {
      return SettingContent(
        user: user,
        tab: widget.settingTab,
      );
    } else {
      return HomeContent(user: user);
    }
  }

  _fetchDataOnPage() {
    NotificationBloc().getTotalUnread().then((value) {
      setState(() {
        notiBadges = value.totalUnreadNoti;
      });
    });
  }
}
