import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../../widgets/task_widget.dart';
import '../../../layout_template/content_screen.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final PageState _pageState = PageState();
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
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 52,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(255, 158, 24, 1),
                            padding:
                                const EdgeInsets.only(top: 16, bottom: 16)),
                        onPressed: () {
                          navigateTo(posttaskRoute);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                SvgIcons.add,
                                color: AppColor.text2,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'ĐĂNG VIỆC MỚI NGAY',
                                style: AppTextTheme.headerTitle(AppColor.text2),
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      child: Text(
                        'Việc từng đăng',
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                      padding: const EdgeInsets.only(top: 24),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TaskWidget(
                  nameButton: 'Đăng lại',
                  onPressed: () {
                    navigateTo(postFastRoute);
                  },
                ),
              )
            ]),
      ),
    );
  }
}

void _fetchDataOnPage() {}
