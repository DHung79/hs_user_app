import 'package:flutter/material.dart';
import 'package:hs_user_app/core/notification/notification.dart';
import 'package:hs_user_app/main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PageState _pageState = PageState();
  final _fakeNoti = [
    NotificationModel.fromJson({
      'title': 'Tasker hủy công việc',
      'body': 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
      'created_time': 1658374817000,
    }),
    NotificationModel.fromJson({
      'title': 'Tasker hủy công việc',
      'body': 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
      'created_time': 1658373488000,
    }),
    NotificationModel.fromJson({
      'title': 'Tasker hủy công việc',
      'body': 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
      'created_time': 1658367617000,
    }),
    NotificationModel.fromJson({
      'title': 'Tasker hủy công việc',
      'body': 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
      'created_time': 1658288417000,
    }),
  ];
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
        builder: (context, snapshot) {
          return PageContent(
            child: _buildContent(),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 56),
                color: AppColor.transparent,
                highlightColor: AppColor.white,
                child: SvgIcon(
                  SvgIcons.arrowBack,
                  size: 24,
                  color: AppColor.black,
                ),
                onPressed: () {
                  navigateTo(homeRoute);
                },
              ),
              Center(
                child: Text(
                  'Thông báo',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(maxWidth: 40),
                color: Colors.transparent,
                highlightColor: AppColor.white,
                child: SvgIcon(
                  SvgIcons.refresh,
                  color: AppColor.text1,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: _fakeNoti.length,
          itemBuilder: (context, index) {
            final noti = _fakeNoti[index];
            final isRead = index + 1 != _fakeNoti.length;
            return _buildNoti(noti, isRead);
          },
        ),
      ],
    );
  }

  Widget _buildNoti(NotificationModel noti, bool isRead) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        border: Border(
          left: isRead
              ? BorderSide(width: 4, color: AppColor.primary2)
              : BorderSide.none,
          bottom: isRead
              ? BorderSide(width: 1, color: AppColor.shade1)
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noti.title,
                    style: AppTextTheme.normalText(
                      AppColor.primary1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      noti.body,
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                  ),
                  Text(
                    timeAgoFromNow(noti.createdTime, context),
                    style: AppTextTheme.normalText(AppColor.text7),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
