import 'package:flutter/material.dart';
import '/main.dart';

class TradeHistory {
  final String name;
  final String money;
  TradeHistory({required this.name, required this.money});
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController controller = TextEditingController();
  int _selectIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  List<TradeHistory> listCost = [
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '+300.000 VND', name: 'Nạp tiền vào ví'),
    TradeHistory(money: '-300.000 VND', name: 'Chi phí hủy dịch vụ'),
    TradeHistory(money: '-400.000 VND', name: 'Chi phí hủy dịch vụ'),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadow.withOpacity(0.16),
                      blurRadius: 16,
                    ),
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
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: _selectIndex == 1
                            ? AppColor.primary1
                            : Colors.transparent,
                        width: 4),
                  ),
                ),
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
            ),
          ],
        ),
        _selectIndex == 0 ? _accountInfo() : _filterField(),
      ],
    );
  }

  Widget _filterField() {
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
              shrinkWrap: true,
              itemCount: listCost.length,
              itemBuilder: (context, index) {
                return _tradeHistoryItem(
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

  Widget _tradeHistoryItem({
    required String title,
    required String money,
    required int index,
  }) {
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

  Widget _accountInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow.withOpacity(0.16),
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
