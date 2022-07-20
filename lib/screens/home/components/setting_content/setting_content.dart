import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hs_user_app/screens/home/components/setting_content/components/edit_password_form.dart';
import 'package:intl/intl.dart';
import '../../../../core/user/user.dart';
import '/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import '/main.dart';
import 'components/edit_profile_form.dart';
import 'components/language_dialog.dart';
import 'components/logout_dialog.dart';
import 'components/payment_screen.dart';

class SettingContent extends StatefulWidget {
  final UserModel user;
  final int tab;
  const SettingContent({
    Key? key,
    required this.user,
    this.tab = 0,
  }) : super(key: key);

  @override
  State<SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<SettingContent> {
  final _userBloc = UserBloc();
  bool _isObscure = true;
  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final screenSize = MediaQuery.of(context).size;

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
          child: _buildHeader(),
        ),
        SizedBox(
          height: screenSize.height - 150 - 24,
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    if (widget.tab != 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButtonTheme.fillRounded(
            constraints: const BoxConstraints(minHeight: 56, maxWidth: 40),
            color: AppColor.transparent,
            highlightColor: AppColor.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgIcon(
                SvgIcons.arrowBack,
                size: 24,
                color: AppColor.black,
              ),
            ),
            onPressed: () {
              if (widget.tab == 1) {
                navigateTo(settingRoute);
              }
              if (widget.tab == 2) {
                navigateTo(userProfileRoute);
              }
              if (widget.tab == 3) {
                navigateTo(userProfileRoute);
              }
              if (widget.tab == 4) {
                navigateTo(settingRoute);
              }
            },
          ),
          Center(
            child: Text(
              _getHeaderTitle(),
              style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
          ),
          AppButtonTheme.fillRounded(
            constraints: const BoxConstraints(maxWidth: 40),
            color: Colors.transparent,
            highlightColor: AppColor.white,
            child: const SizedBox(),
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          'Cài đặt',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
      );
    }
  }

  String _getHeaderTitle() {
    switch (widget.tab) {
      case 1:
        return 'Hồ sơ người dùng';
      case 2:
        return 'Chỉnh sửa hồ sơ';
      case 3:
        return 'Đổi mật khẩu';
      case 4:
        return 'Ví điện tử';
      default:
        return '';
    }
  }

  Widget _userAvatar() {
    return Row(
      children: [
        ClipOval(
          child: widget.user.avatar.isNotEmpty
              ? Image.network(
                  widget.user.avatar,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/logo.png",
                  width: 80,
                  height: 80,
                ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.user.name,
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                ),
                Text(
                  widget.user.email,
                  style: AppTextTheme.mediumBodyText(AppColor.nameText),
                ),
                InkWell(
                  splashColor: AppColor.transparent,
                  highlightColor: AppColor.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            widget.tab == 0 ? 'Xem hồ sơ' : 'Đổi mật khẩu',
                            style: AppTextTheme.normalText(AppColor.primary2),
                          ),
                        ),
                        if (widget.tab == 0)
                          Transform.rotate(
                            angle: 180 * pi / 180,
                            child: SvgIcon(
                              SvgIcons.arrowBack,
                              color: AppColor.primary2,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (widget.tab == 0) {
                      navigateTo(userProfileRoute);
                    } else {
                      navigateTo(userChangePasswordRoute);
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    if (widget.tab > 1) {
      return widget.tab == 4
          ? const PaymentScreen()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (widget.tab == 2) EditProfileForm(user: widget.user),
                  if (widget.tab == 3) EditPasswordForm(user: widget.user),
                ],
              ),
            );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 24),
              child: _userAvatar(),
            ),
            widget.tab == 0 ? _buildSettingContent() : _buildUserProfile(),
          ],
        ),
      );
    }
  }

  Widget _buildSettingContent() {
    final settingMenu = [
      SettingMenuItem(
        name: 'Payment',
        icon: SvgIcons.wallet,
        onTap: () {
          navigateTo(paymentRoute);
        },
      ),
      SettingMenuItem(
        name: 'Đánh giá ứng dụng',
        icon: SvgIcons.starOutline,
        onTap: () {},
      ),
      SettingMenuItem(
        name: 'Ngôn ngữ',
        icon: SvgIcons.language,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return const LanguageDialog();
            },
          );
        },
      ),
      SettingMenuItem(
        name: 'Đăng xuất',
        icon: SvgIcons.logout,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return LogoutDialog(
                  onPressed: () {
                    _handleSignOut();
                  },
                );
              });
        },
      ),
    ];
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.16),
            blurStyle: BlurStyle.outer,
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: settingMenu.length,
          itemBuilder: (BuildContext context, index) {
            final item = settingMenu[index];
            return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: item.onTap,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: index != 3
                        ? BorderSide(width: 1, color: AppColor.shade1)
                        : BorderSide.none,
                  ),
                ),
                child: Row(
                  children: [
                    SvgIcon(
                      item.icon,
                      size: 24,
                      color: AppColor.shade5,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      item.name,
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    int value = 120000000;
    final title = _isObscure
        ? value.toString().replaceAll(RegExp(r"."), "*") + ' VND'
        : NumberFormat('#,##0 VND', 'vi').format(value);

    return Column(
      children: [
        _userInfoTab(
          title: 'Liên lạc',
          child: Column(
            children: [
              _buildProfileDetail(
                icon: SvgIcons.alternateEmail,
                title: widget.user.email,
              ),
              _buildProfileDetail(
                icon: SvgIcons.telephone,
                title: widget.user.phoneNumber,
              ),
              _buildProfileDetail(
                icon: SvgIcons.locationOutline,
                title: widget.user.address,
              ),
            ],
          ),
          onPressed: () {
            navigateTo(editProfileRoute);
          },
        ),
        _userInfoTab(
            title: 'Ví điện tử',
            onPressed: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    children: [
                      SvgIcon(
                        SvgIcons.dollar,
                        color: AppColor.shade5,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: Text(
                          title,
                          style: AppTextTheme.normalText(AppColor.text1),
                        ),
                      ),
                      InkWell(
                        splashColor: AppColor.transparent,
                        highlightColor: AppColor.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 19,
                            horizontal: 8,
                          ),
                          child: Text(
                            'Hiển thị',
                            style:
                                AppTextTheme.mediumBodyText(AppColor.primary2),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: AppColor.shade1,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Nạp thêm tiền',
                      style: AppTextTheme.headerTitle(AppColor.shade9),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildProfileDetail({
    required String title,
    required SvgIconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          SvgIcon(
            icon,
            color: AppColor.shade5,
            size: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
              child: Text(
                title,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userInfoTab({
    required String title,
    Function()? onPressed,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                  InkWell(
                    splashColor: AppColor.transparent,
                    highlightColor: AppColor.transparent,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: SvgIcon(
                          SvgIcons.editOutline,
                          color: AppColor.text7,
                          size: 24,
                        ),
                      ),
                    ),
                    onTap: onPressed,
                  ),
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  _handleSignOut() {
    _googleSignIn.signOut().then((value) {
      AuthenticationBlocController().authenticationBloc.add(UserLogOut());
      Navigator.of(context).pop();
    }).onError((error, stackTrace) => logDebug(error));
  }
}

class SettingMenuItem {
  String name;
  SvgIconData icon;
  Function()? onTap;

  SettingMenuItem({
    required this.name,
    required this.icon,
    this.onTap,
  });
}
