import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../core/user/model/user_model.dart';
import '../../theme/svg_constants.dart';
import '../layout_template/content_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            child: content(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        elevation: 16,
        backgroundColor: AppColor.text2,
        title: Text(
          'Thông báo',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: SvgIcon(
              SvgIcons.rotateRight1,
              color: AppColor.text1,
              size: 24,
            ),
          ),
        ],
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
      body: ListView(
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '30 phút trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '1 giờ trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 giờ trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
            time: '3 ngày trước',
          ),
          _taskerRemove(
            name: 'Tasker hủy công việc',
            content: 'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn ahihihii',
            time: '3 ngày trước',
          ),
        ],
      ),
    );
  }

  Widget _taskerRemove({
    required String name,
    required String content,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 4, color: AppColor.primary2),
          bottom: BorderSide(width: 1, color: AppColor.shade1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                backgroundColor: AppColor.primary1,
              ),
            ),
            const SizedBox(
              width: 19,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextTheme.normalText(AppColor.primary1),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    content,
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    time,
                    style: AppTextTheme.normalText(AppColor.text7),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
