import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hs_user_app/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../core/user/bloc/user_bloc.dart';
import '../../../core/user/model/user_model.dart';
import '../../../routes/route_names.dart';
import '../../layout_template/content_screen.dart';

enum SelectLanguage { tiengviet, english }

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();

  SelectLanguage _language = SelectLanguage.english;

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
            child: snapshot.hasData
                ? content(snapshot)
                : const SizedBox(),
          );
        },
      ),
    );
  }

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.text2,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 16,
          title: Text(
            'Cài đặt',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Row(children: [
                if (user?.avatar != '')
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user!.avatar),
                ),
                if (user?.avatar == '')
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColor.primary1,
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
                          user!.name,
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
                      TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(0, 0),
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                          primary: AppColor.text2,

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
                                style:
                                    AppTextTheme.normalText(AppColor.primary2),
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
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(79, 117, 140, 0.16),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 16.0)
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
        ),
      ),
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

  _fetchDataOnPage() {}
}

class Infor {
  String payment;
  String rating;
  String language;
  String logout;

  Infor(this.payment, this.rating, this.language, this.logout);
}
