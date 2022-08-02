import 'package:flutter/material.dart';
import '../../../../core/user/user.dart';
import '/main.dart';

class HomeContent extends StatefulWidget {
  final UserModel user;
  const HomeContent({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _userBloc = UserBloc();

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                blurStyle: BlurStyle.outer,
                color: AppColor.shadow.withOpacity(0.16),
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.zero,
              bottom: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      splashColor: AppColor.transparent,
                      highlightColor: AppColor.transparent,
                      onTap: () {
                        navigateTo(settingRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          width: 64,
                          padding: const EdgeInsets.fromLTRB(0, 28, 24, 28),
                          child: _userAvatar(),
                        ),
                      ),
                    ),
                    _buildHeader(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildNotification(),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Dịch vụ',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                ),
                _buildTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _userAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: widget.user.avatar.isNotEmpty
          ? Image.network(
              widget.user.avatar,
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            )
          : Image.asset(
              "assets/images/logo.png",
              width: 40,
              height: 40,
            ),
    );
  }

  Widget _buildHeader() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Xin chào ${widget.user.name}',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Đã 5 ngày rồi bạn chưa dọn dẹp',
            style: AppTextTheme.normalText(AppColor.text8),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashFactory: NoSplash.splashFactory,
                primary: AppColor.text2,
              ),
              onPressed: () {
                navigateTo(bookNewTaskRoute);
              },
              child: Text(
                'ĐĂNG NGAY',
                style: AppTextTheme.mediumBodyText(AppColor.primary2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.24),
            blurRadius: 16,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset('assets/images/logo_cover.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Dọn dẹp theo giờ',
                      style: AppTextTheme.mediumHeaderTitle(
                        AppColor.primary1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Bạn không có thời gian để dọn dẹp?\nHãy để II home giúp bạn với đội ngũ chuyên nghiệp',
                      style: AppTextTheme.normalText(AppColor.text3),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const Divider(
                height: 2,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              navigateTo(bookNewTaskRoute);
            },
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Trải nghiệm dịch vụ',
                  style: AppTextTheme.normalHeaderTitle(AppColor.primary2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotification() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.16),
            blurStyle: BlurStyle.outer,
            blurRadius: 16,
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          navigateTo(notificationRoute);
        },
        style: TextButton.styleFrom(
          primary: AppColor.text2,
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
          minimumSize: const Size(24, 24),
          shadowColor: AppColor.shadow.withOpacity(0.16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.notifications,
                color: AppColor.text1,
                size: 24,
              ),
              if (notiBadges > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: SizedBox(
                    width: 26,
                    height: 26,
                    child: CircleAvatar(
                      backgroundColor: AppColor.others1,
                      child: Text(
                        notiBadges > 10 ? '9+' : '$notiBadges',
                        style: AppTextTheme.mediumBodyText(AppColor.text2),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
