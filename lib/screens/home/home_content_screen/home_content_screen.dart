import 'package:flutter/material.dart';
import '/main.dart';
import '/routes/route_names.dart';
import '/widgets/jt_indicator.dart';
import '../../../core/user/bloc/user_bloc.dart';
import '../../../core/user/model/user_model.dart';
import '../../../theme/svg_constants.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    Key? key,
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
    return StreamBuilder(
        stream: _userBloc.getProfile().asStream(),
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
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
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: _avatarHome(user),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              _buildHeader(user),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.shadow.withOpacity(0.24),
                                  blurRadius: 16)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child:
                                    Image.asset('assets/images/logodemo.png'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          style: AppTextTheme.normalText(
                                              AppColor.text3),
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
                                  style: AppTextTheme.normalHeaderTitle(
                                      AppColor.primary2),
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
          return const JTIndicator();
        });
  }

  Widget _avatarHome(UserModel? user) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: user!.avatar.isNotEmpty
          ? Image.network(
              user.avatar,
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

  Widget _buildHeader(UserModel user) {
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            SvgIcon(
              SvgIcons.notificationsOne,
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
          ]),
        ),
      ),
    );
  }
}
