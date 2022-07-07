import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../routes/route_names.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

class CodeSaleoff {
  final String code;
  final String saleoff;

  CodeSaleoff({required this.code, required this.saleoff});
}

class Promotion extends StatefulWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final _pageState = PageState();
  List<CodeSaleoff> listcode = [
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
    CodeSaleoff(code: "JOYTECH06", saleoff: 'Giảm 20%'),
  ];
  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
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
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            return PageContent(
              onFetch: () {
                _fetchDataOnPage();
              },
              pageState: _pageState,
              child: Scaffold(
                backgroundColor: AppColor.text2,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: LayoutBuilder(builder: (context, size) {
                    return AppBar(
                      title: Text(
                        'Danh sách khuyến mãi',
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
                  }),
                ),
                body: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listcode.length,
                    itemBuilder: (context, index) {
                      return codesaleoff(
                          code: listcode[index].code,
                          saleoff: listcode[index].saleoff);
                    }),
              ),
            );
          },
        ));
  }

  Padding codesaleoff({required String code, required String saleoff}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color.fromRGBO(79, 117, 140, 0.16),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.text2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgIcon(
                      SvgIcons.dailyTask,
                      size: 40,
                      color: AppColor.text1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              code,
                              style: AppTextTheme.mediumHeaderTitle(
                                  AppColor.text1),
                            ),
                          ),
                          Text(
                            saleoff,
                            style: AppTextTheme.normalText(AppColor.primary1),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                color: AppColor.text2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 28, horizontal: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(0, 0)),
                onPressed: () {},
                child: Text(
                  'SỬ DỤNG',
                  style: AppTextTheme.mediumBodyText(AppColor.primary2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
