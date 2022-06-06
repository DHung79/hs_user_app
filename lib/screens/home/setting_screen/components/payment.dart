import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';
import '../model/cost_model.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PageState _pageState = PageState();
  TextEditingController controller = TextEditingController();
  int _selectIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  List<Cost> listCost = [
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    Cost(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    Cost(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
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
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: content(context), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        backgroundColor: AppColor.text2,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            navigateTo(settingRoute);
          },
          child: SvgIcon(
            SvgIcons.arrowBack,
            size: 24,
            color: AppColor.text1,
          ),
        ),
        title: Text(
          'Ví điện tử',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(79, 117, 140, 0.16),
                        blurRadius: 16,
                        offset: Offset(3, 0)),
                  ],
                  border: Border(
                    bottom: BorderSide(
                        color: _selectIndex == 0
                            ? AppColor.primary1
                            : Colors.transparent,
                        width: 4),
                  ),
                ),
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      _onItemTapped(0);
                    },
                    child: Text(
                      'Tài khoản',
                      style: _selectIndex == 0
                          ? AppTextTheme.normalText(AppColor.primary1)
                          : AppTextTheme.normalText(AppColor.text3),
                    )),
              ),
              Container(
                height: 52,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: _selectIndex == 1
                                ? AppColor.primary1
                                : Colors.transparent,
                            width: 4))),
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      _onItemTapped(1);
                    },
                    child: Text(
                      'Giao dịch',
                      style: _selectIndex == 1
                          ? AppTextTheme.normalText(AppColor.primary1)
                          : AppTextTheme.normalText(AppColor.text3),
                    )),
              ),
            ],
          ),
          _selectIndex == 0 ? account() : transaction(),
        ],
      ),
    );
  }

  Expanded transaction() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.text7,
                            width: 1,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.text7,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.text7,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(24, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: SvgIcon(
                    SvgIcons.filter1,
                    size: 24,
                    color: AppColor.text7,
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.text2,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          height: 192,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Bộ lọc',
                                    style: AppTextTheme.mediumHeaderTitle(
                                        AppColor.text1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Tiền vào',
                                    style: AppTextTheme.mediumBodyText(
                                        AppColor.text3),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Tiền ra',
                                    style: AppTextTheme.mediumBodyText(
                                        AppColor.text3),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColor.primary2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tháng 3/2022',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text2),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        'Chi: 300.000 VNĐ',
                        style: AppTextTheme.subText(AppColor.text2),
                      ),
                    ),
                    Text(
                      'Nạp: 300.000 VNĐ',
                      style: AppTextTheme.subText(AppColor.text2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listCost.length,
              itemBuilder: (context, index) {
                return cost(
                  title: listCost[index].name,
                  money: listCost[index].money,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container cost(
      {required String title, required String money, required int index}) {
    return Container(
      color: index % 2 == 0 ? AppColor.text2 : AppColor.shade1,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  title,
                  style: AppTextTheme.normalText(AppColor.text1),
                ),
              ),
              Text(
                '20:49 24/03/2022',
                style: AppTextTheme.superSmallText(AppColor.text1),
              ),
            ],
          ),
          Text(
            money,
            style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
          ),
        ],
      ),
    );
  }

  Padding account() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(79, 117, 140, 0.16),
              blurStyle: BlurStyle.outer,
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Số tiền trong tài khoản',
                      style: AppTextTheme.mediumBodyText(AppColor.text7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgIcon(
                              SvgIcons.dollar1,
                              size: 24,
                              color: AppColor.primary2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                '300.000 VND',
                                style:
                                    AppTextTheme.mediumBigText(AppColor.text1),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(24, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: SvgIcon(
                            SvgIcons.removeredEye,
                            size: 24,
                            color: AppColor.text7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SvgIcon(
                        SvgIcons.trophy1,
                        size: 24,
                        color: AppColor.primary2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '234',
                          style: AppTextTheme.mediumBigText(AppColor.text1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'points',
                          style: AppTextTheme.normalText(AppColor.text1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppColor.shade1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Nạp thêm tiền',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary2),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
