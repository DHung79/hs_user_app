import 'package:flutter/material.dart';
import 'package:hs_user_app/screens/home/booking_screen/widgets/dialog.dart';

import '../../../../core/user/model/user_model.dart';
import '../../../../utils/screen_util.dart';
import '../../../layout_template/content_screen.dart';

class TaskNow extends StatefulWidget {
  const TaskNow({Key? key}) : super(key: key);

  @override
  State<TaskNow> createState() => _TaskNowState();
}

class _TaskNowState extends State<TaskNow> {
 final  PageState _pageState = PageState();
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
            child: const DialogWidget(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }
}

void _fetchDataOnPage() {
}
