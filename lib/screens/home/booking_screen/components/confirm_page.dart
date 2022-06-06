import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/bloc/user_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../models/profile_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

class Confirm extends StatefulWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  String fakeCode = 'JOYTECH';
  final TextEditingController _code = TextEditingController();
  String? code;
  String money = '230000';
  bool showMoney = true;

  hideMoney() {
    String text = '';
    for (var i = 0; i < money.length; i++) {
      text += '*';
    }
    return text;
  }

  List<ProfileModel> fakeProfiles = [
    ProfileModel(
      'Thông tin của bạn',
      'Julies Nguyen',
      '(+84) 0335475756',
      '358/12/33 Lư Cẩm, Ngọc Hiệp - Nha Trang - Khánh Hòa',
      'Thông tin công việc',
      '3 tiếng, 14:00 đến 17:00',
      'thứ 6, 25/03/2022',
      '55 m2 / 2 phòng',
      'Hình thức thanh toán',
      'Thanh toán bằng tiền mặt',
    ),
  ];

  final List profileIcons = [
    SvgIcon(
      SvgIcons.user1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.telephone1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.epLocation,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.accessTime,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.calenderToday,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.clipboard1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.wallet1,
      color: AppColor.shade5,
      size: 24,
    ),
  ];

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

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: LayoutBuilder(
          builder: (context, size) {
            return AppBar(
              title: Text(
                'Xác nhận và thanh toán',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              centerTitle: true,
              backgroundColor: AppColor.text2,
              shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
              elevation: 8,
              leading: TextButton(
                onPressed: () {
                  navigateTo(posttaskRoute);
                },
                child: SvgIcon(
                  SvgIcons.arrowBack,
                  size: 24,
                  color: AppColor.text1,
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: profileIcons.length,
            itemBuilder: (BuildContext context, iconIndex) {
              return _item(
                iconIndex,
                task: fakeProfiles[0],
                icons: profileIcons,
                user: user!,
              );
            },
          ),
          yourProfile2(
              money: money,
              onPressed: () {
                setState(() {
                  showMoney = !showMoney;
                });
              }),
          TextField(
            onChanged: (value) {
              setState(() {
                code = value;
              });
            },
            controller: _code,
            style: AppTextTheme.normalText(AppColor.text7),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.shade4,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      navigateTo(promotionRoute);
                    },
                    child: SvgIcon(
                      SvgIcons.tag1,
                      size: 24,
                      color: AppColor.primary2,
                    ),
                  ),
                ),
                prefixIcon: fakeCode == code
                    ? const Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: SvgIcon(
                          SvgIcons.close,
                          color: AppColor.others1,
                          size: 24,
                        ),
                      ),
                hintText: 'Nhập mã khuyến mãi',
                hintStyle: AppTextTheme.normalText(AppColor.text7),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: AppColor.text7)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: AppColor.text7)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: AppColor.text7)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: AppColor.text7))),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                fakeCode == _code.text
                    ? Text(
                        '190,000 VND',
                        style:
                            AppTextTheme.normalHeaderTitleLine(AppColor.text7),
                      )
                    : const Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                    Text(
                      '210,000 VND',
                      style: AppTextTheme.mediumBigText(AppColor.text1),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppColor.shade9,
                  padding: const EdgeInsets.only(top: 16, bottom: 16)),
              onPressed: () {},
              child: Text(
                'ĐĂNG VIỆC',
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
            ),
          )
        ]),
      )),
    );
  }

  Widget yourProfile2(
      {required String money, required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  color: AppColor.shade10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgIcon(
                  SvgIcons.dollar1,
                  size: 24,
                  color: AppColor.shade5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Số dư: ',
                  style: AppTextTheme.normalText(AppColor.text1),
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                showMoney == true ? money + ' VND' : hideMoney(),
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: onPressed,
                  child: SvgIcon(
                    SvgIcons.removeredEye,
                    size: 24,
                    color: AppColor.text7,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row yourProfile({required String task, required void Function()? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          task,
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
            backgroundColor: AppColor.shade1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Text(
            'Thay đổi',
            style: AppTextTheme.normalText(AppColor.text3),
          ),
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget _item(int i,
      {required ProfileModel task,
      required List icons,
      required UserModel user}) {
    String text = '';
    if (i == 0) {
      text = user.name;
    } else if (i == 1) {
      text = user.phoneNumber;
    } else if (i == 2) {
      text = user.address;
    } else if (i == 3) {
      text = task.hours;
    } else if (i == 4) {
      text = task.week;
    } else if (i == 5) {
      text = task.sizeRoom;
    } else if (i == 6) {
      text = task.pay;
    }

    // print(i++);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          i == 0
              ? yourProfile(
                  task: fakeProfiles[0].title,
                  onPressed: () {
                    navigateTo(editProfileRoute);
                  })
              : Row(),
          i == 3
              ? yourProfile(task: fakeProfiles[0].title2, onPressed: () {})
              : Row(),
          i == 6
              ? yourProfile(task: fakeProfiles[0].title3, onPressed: () {})
              : Row(),
          // i == 6 ? yourProfile2() : Row(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.shade10,
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(8.0),
                child: icons[i],
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  text,
                  style: AppTextTheme.normalText(AppColor.text1),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}
