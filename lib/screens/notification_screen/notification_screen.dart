import 'package:flutter/material.dart';
import 'package:hs_user_app/core/notification/notification.dart';
import 'package:hs_user_app/main.dart';
import '../../core/user/user.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PageState _pageState = PageState();
  final _notiBloc = NotificationBloc();
  final _scrollController = ScrollController();
  int maxPage = 0;
  int currentPage = 1;
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _notiBloc.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (currentPage < maxPage) {
        currentPage += 1;
        _fetchDataOnPage(currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {},
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return PageContent(
              child: _buildContent(user),
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage(1);
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildContent(UserModel user) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      child: Column(
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
                  onPressed: () {
                    _fetchDataOnPage(1);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _notiBloc.allData,
              builder: (context,
                  AsyncSnapshot<ApiResponse<NotificationListModel?>> snapshot) {
                if (snapshot.hasData) {
                  if (notifications.isNotEmpty) {
                    final records = snapshot.data!.model!.records;
                    for (var noti in records) {
                      if (notifications.where((e) => e.id == noti.id).isEmpty) {
                        notifications.add(noti);
                      }
                    }
                  } else {
                    notifications = snapshot.data!.model!.records;
                  }
                  maxPage = snapshot.data!.model!.meta.totalPage;
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final noti = notifications[index];
                      return _buildNoti(
                        noti,
                        isLast: notifications.length - 1 == index,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoti(NotificationModel noti, {bool isLast = false}) {
    final screenSize = MediaQuery.of(context).size;
    bool isRead = noti.read;
    return StatefulBuilder(builder: (context, setState) {
      return InkWell(
        child: Container(
          width: screenSize.width,
          decoration: BoxDecoration(
            border: Border(
              left: !isRead
                  ? BorderSide(width: 4, color: AppColor.primary2)
                  : BorderSide.none,
              bottom: !isLast
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
        ),
        onTap: () {
          _notiBloc.readNotiById(id: noti.id).then((value) {
            setState(() {
              isRead = value.read;
            });
          });
        },
      );
    });
  }

  _fetchDataOnPage(
    int page,
  ) {
    _notiBloc.fetchAllData(params: {
      'limit': 10,
      'page': page,
    });
    _notiBloc.getTotalUnread().then((value) {
      setState(() {
        notiBadges = value.totalUnreadNoti;
      });
    });
  }

  refreshData() {
    maxPage = 0;
    currentPage = 1;
    notifications.clear();
    _notiBloc.fetchAllData(params: {
      'limit': 10,
      'page': currentPage,
    });
  }
}
