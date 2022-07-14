import 'package:flutter/material.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/user/user.dart';
import '/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  List icons = [
    SvgIcon(
      SvgIcons.alternateEmail,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.telephone1,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.epLocation,
      size: 24,
      color: AppColor.shade5,
    ),
  ];

  hideMoney() {
    String text = '';
    for (var i = 0; i < money.length; i++) {
      text += '*';
    }
    return text;
  }

  String money = '3434';
  bool showMoney = true;

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

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 16,
        centerTitle: true,
        title: Text(
          'Hồ sơ người dùng',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        shadowColor: AppColor.shadow.withOpacity(0.16),
        leading: TextButton(
          child: SvgIcon(
            SvgIcons.arrowBack,
            color: AppColor.text1,
            size: 24,
          ),
          onPressed: () {
            navigateTo(homeRoute);
          },
        ),
      ),
      body: _buildContent(user!),
    );
  }

  Container _buildContent(UserModel user) {
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
              backgroundColor: AppColor.primary1,
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
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      user.email,
                      style: AppTextTheme.mediumBodyText(AppColor.nameText),
                    ),
                  ),
                  loginGoogle == true
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            navigateTo(userChangePasswordRoute);
                          },
                          child: Text(
                            'Đổi mật khẩu',
                            style: AppTextTheme.normalText(AppColor.primary2),
                          ),
                        ),
                ],
              ),
            )
          ]),
        ),
        contact(user),
        const SizedBox(
          height: 32,
        ),
        contentProfile(context),
      ]),
    );
  }

  Container contact(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16.0,
            ),
          ]),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Liên lạc',
              style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            TextButton(
              onPressed: () {
                navigateTo(editProfileRoute);
              },
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(24, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: SvgIcon(
                SvgIcons.antDesignEditOutlined,
                color: AppColor.text7,
                size: 24,
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return _item(index, user: user);
          },
          itemCount: icons.length,
        )
      ]),
    );
  }

  Container _item(i, {required UserModel user}) {
    String text = '';
    if (i == 0) {
      text = user.email;
    } else if (i == 1) {
      text = user.phoneNumber;
    } else {
      text = user.address;
    }

    return Container(
      padding: const EdgeInsets.only(top: 16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          icons[i],
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 98,
            child: Text(
              text,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
          )
        ],
      ),
    );
  }

  Container contentProfile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16.0,
            ),
          ]),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ví điện tử',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              SvgIcon(
                SvgIcons.antDesignEditOutlined,
                color: AppColor.text7,
                size: 24,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.dollar1,
                color: AppColor.shade5,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                showMoney == true ? money + ' VND' : hideMoney(),
                style: AppTextTheme.normalText(AppColor.text1),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                child: Text(
                  'Hiển thị',
                  style: AppTextTheme.mediumBodyText(AppColor.primary2),
                ),
                onTap: () {
                  setState(() {
                    showMoney = !showMoney;
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
        )
      ]),
    );
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}

class Infor {
  String email;
  String numberPhone;
  String address;

  Infor(
    this.email,
    this.numberPhone,
    this.address,
  );
}
