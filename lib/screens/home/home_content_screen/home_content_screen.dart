import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../core/user/bloc/user_bloc.dart';
import '../../../core/user/model/user_model.dart';
import '../../../theme/svg_constants.dart';
import '../../layout_template/content_screen.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _pageState = PageState();
  final _userBloc = UserBloc();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    _userBloc.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

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
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
            child: snapshot.hasData ? content(snapshot) : const SizedBox(),
          );
        },
      ),
    );
  }

  Container content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      blurStyle: BlurStyle.outer,
                      color: Color.fromRGBO(79, 117, 140, 0.16)),
                ],
                borderRadius: BorderRadius.vertical(
                top: Radius.zero,
                bottom: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: avatarHome(user!),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      helloContent(user),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: notification(),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Expanded(
              child: Container(
            // color: Colors.white,
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dịch vụ',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x4F758C29).withOpacity(0.24),
                          blurRadius: 16)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.asset('assets/images/logodemo.png'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  style:
                                      AppTextTheme.normalText(AppColor.text3),
                                  maxLines: 5,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 2,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Trải nghiệm dịch vụ',
                          style:
                              AppTextTheme.normalHeaderTitle(AppColor.primary2),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  ClipRRect avatarHome(UserModel? user) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(20),
        // size: Size.fromRadius(40), // Image radius
        child: Image.network(
          user!.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget helloContent(UserModel user) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Xin chào ${user.name}',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Đã 5 ngày tồi bạn chưa dọn dẹp',
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
                navigateTo(posttaskRoute);
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

  Container notification() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(79, 117, 140, 0.16),
              blurStyle: BlurStyle.outer,
              blurRadius: 16,
            )
          ]),
      child: TextButton(
        onPressed: () {
          navigateTo(notificationRoute);
        },
        style: TextButton.styleFrom(
          primary: AppColor.text2,
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
          minimumSize: const Size(24, 24),
          shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),

          // fixedSize: const Size(0, 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            SvgIcon(
              SvgIcons.notificationsOne,
              color: AppColor.text1,
              size: 24,
            ),
            const SizedBox(
              width: 13,
            ),
            SizedBox(
              width: 26,
              height: 26,
              child: CircleAvatar(
                backgroundColor: AppColor.others1,
                child: Text(
                  '9+',
                  style: AppTextTheme.mediumBodyText(AppColor.text2),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}
