import 'package:flutter/material.dart';
import '/main.dart';
import '/routes/route_names.dart';
import '/screens/home/booking_screen/components/choose_location/choose_location.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';

final pickTypeHomeKey = GlobalKey<_PickTypeHomeState>();

class PickTypeHome extends StatefulWidget {
  const PickTypeHome({Key? key}) : super(key: key);

  @override
  State<PickTypeHome> createState() => _PickTypeHomeState();
}

class _PickTypeHomeState extends State<PickTypeHome> {
  final _pageState = PageState();
  final List _typeHome = ['Nhà ở', 'Căn hộ', 'Biệt thự'];
  final TextEditingController addressTitle = TextEditingController();
  int _index = 0;
  int typeHome = 0;
  String? nameAddress;
  @override
  void initState() {
    nameAddress = chooseLocationKey.currentState?.nameAddressChoose;
    super.initState();
  }

  @override
  void dispose() {
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
            child: content(),
          );
        },
      ),
    );
  }

  Widget content() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        leading: BackButton(
            color: AppColor.text1,
            onPressed: () {
              navigateTo(chooseLocationRoute);
            }),
        title: Text(
          'Chọn loại nhà, số nhà',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Loại nhà',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                ),
                for (int i = 0; i < _typeHome.length; i++)
                  _typeHomeList(
                      i: i,
                      onPressed: () {
                        setState(() {
                          _index = i;
                        });
                      }),
                Text(
                  'Địa chỉ cụ thể',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: addressTitle,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Số nhà 1, hẻm 2',
                        hintStyle: AppTextTheme.normalText(AppColor.text7),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColor.text7, width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColor.text7, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColor.text7, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '*Nhập địa chỉ cụ thể để người giúp việc có thể tìm chính xác nơi làm việc',
                  style: AppTextTheme.normalText(AppColor.text1),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary2,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    typeHome = _index;
                    navigateTo(bookNewTaskRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Đồng ý'.toUpperCase(),
                      style: AppTextTheme.headerTitle(AppColor.text2),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _typeHomeList({required int i, required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: i == _index ? AppColor.primary1 : AppColor.text7,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _typeHome[i],
                  style: AppTextTheme.normalText(
                      i == _index ? AppColor.primary1 : AppColor.text3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
