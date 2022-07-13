import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/user/user.dart';
import '/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import '/main.dart';

enum SelectLanguage { tiengviet, english }

class SettingContent extends StatefulWidget {
  const SettingContent({Key? key}) : super(key: key);

  @override
  State<SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<SettingContent> {
  SelectLanguage _language = SelectLanguage.english;
  final _userBloc = UserBloc();

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  final List<Infor> fakeProfile = [
    Infor('Payment', 'Đánh giá ứng dụng', 'Ngôn ngữ', 'Đăng xuất'),
  ];

  final List icons = [
    SvgIcon(
      SvgIcons.wallet1,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.starOutline,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.language,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.logout,
      size: 24,
      color: AppColor.shade5,
    )
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final screenSize = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _userBloc.getProfile().asStream(),
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
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
                  child: Center(
                    child: Text(
                      'Cài đặt',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height - 150 - 24,
                  child: _buildContent(user),
                ),
              ],
            );
          }
          return const SizedBox();
        });
  }

  Widget _buildContent(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          child: Row(children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.avatar),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      user.name,
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      user.email,
                      style: AppTextTheme.mediumBodyText(AppColor.nameText),
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(24, 24),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        navigateTo(settingProfileRoute);
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              'Xem hồ sơ',
                              style: AppTextTheme.normalText(AppColor.primary2),
                            ),
                          ),
                          Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..rotateZ(180 * 3.1415927 / 180),
                            child: SvgIcon(
                              SvgIcons.arrowBack,
                              color: AppColor.primary2,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        Container(
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
              itemBuilder: (BuildContext context, index) {
                return _item(index, info: fakeProfile[0]);
              },
              itemCount: icons.length,
            ),
          ),
        )
      ]),
    );
  }

  Widget _item(int i, {required Infor info}) {
    String text = '';
    if (i == 0) {
      text = info.payment;
    } else if (i == 1) {
      text = info.rating;
    } else if (i == 2) {
      text = info.language;
    } else {
      text = info.logout;
    }
    // print(i++);
    return InkWell(
      onTap: i == 3
          ? _showMaterialDialog
          : i == 0
              ? () {
                  navigateTo(paymentRoute);
                }
              : i == 2
                  ? selectLanguage
                  : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            border: Border(
          bottom: i != 3
              ? BorderSide(width: 1, color: AppColor.shade1)
              : BorderSide.none,
        )),
        child: Row(
          children: [
            icons[i],
            const SizedBox(
              width: 11,
            ),
            Text(
              text,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 334,
              height: 282,
              decoration: BoxDecoration(
                  color: AppColor.text2,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đăng xuất',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                  Container(
                    color: AppColor.shade1,
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      'Bạn có chắc chắn muốn đăng xuất?',
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                  ),
                  SizedBox(
                    height: 52,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.primary2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {
                        _handleSignOut();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            SvgIcons.logout,
                            color: AppColor.text2,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Đăng xuất',
                              style: AppTextTheme.headerTitle(AppColor.text2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 52,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.shade1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            SvgIcons.arrowBack,
                            color: AppColor.text3,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Trở về',
                              style: AppTextTheme.headerTitle(AppColor.text3),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void selectLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Container(
              width: 334,
              height: 272,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chọn ngôn ngữ',
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: SvgIcon(
                          SvgIcons.close,
                          size: 24,
                          color: AppColor.text1,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(
                      height: 1,
                      color: AppColor.shade1,
                    ),
                  ),
                  radiobutton(
                    name: 'Tiếng Việt',
                    onChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                    value: SelectLanguage.tiengviet,
                  ),
                  radiobutton(
                    name: 'English',
                    onChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                    value: SelectLanguage.english,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.shade1,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            SvgIcons.arrowBack,
                            color: AppColor.text1,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Trở về',
                              style: AppTextTheme.headerTitle(AppColor.text3),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Padding radiobutton(
      {required dynamic value,
      required void Function(dynamic)? onChanged,
      required String name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
              width: 24,
              child: Radio(
                  activeColor: AppColor.text1,
                  value: value,
                  groupValue: _language,
                  onChanged: onChanged)),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              name,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    AuthenticationBlocController().authenticationBloc.add(UserLogOut());
    navigateTo(authenticationRoute);
    homePageIndex = 0;
    selectIndexBooking = 0;
  }
}

class Infor {
  String payment;
  String rating;
  String language;
  String logout;

  Infor(this.payment, this.rating, this.language, this.logout);
}
