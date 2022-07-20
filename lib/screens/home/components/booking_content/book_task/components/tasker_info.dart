import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../core/tasker/tasker.dart';
import '../../../../../../main.dart';

class TaskerInfo extends StatefulWidget {
  final String taskerId;
  const TaskerInfo({
    Key? key,
    required this.taskerId,
  }) : super(key: key);

  @override
  State<TaskerInfo> createState() => _TaskerInfoState();
}

class _TaskerInfoState extends State<TaskerInfo> {
  final _taskerBloc = TaskerBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _taskerBloc.fetchDataById(widget.taskerId).asStream(),
        builder: (context, AsyncSnapshot<TaskerModel> snapshot) {
          if (snapshot.hasData) {
            final tasker = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow.withOpacity(0.16),
                        blurRadius: 16,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtonTheme.fillRounded(
                        constraints:
                            const BoxConstraints(minHeight: 56, maxWidth: 40),
                        color: AppColor.transparent,
                        highlightColor: AppColor.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SvgIcon(
                            SvgIcons.arrowBack,
                            size: 24,
                            color: AppColor.black,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Center(
                        child: Text(
                          'Thông tin người làm',
                          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                        ),
                      ),
                      AppButtonTheme.fillRounded(
                        constraints: const BoxConstraints(maxWidth: 40),
                        color: Colors.transparent,
                        highlightColor: AppColor.white,
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipOval(
                              child: tasker.avatar.isNotEmpty
                                  ? Image.network(
                                      tasker.avatar,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/logo.png",
                                      width: 100,
                                      height: 100,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            tasker.name,
                            style: AppTextTheme.mediumBigText(AppColor.text3),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => SvgIcon(
                            SvgIcons.starSticker,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 50.0,
                          direction: Axis.vertical,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                          child: Text(
                            '(643 đánh giá)',
                            style: AppTextTheme.normalText(AppColor.text1),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _profileTasker(
                                title: 'Tham gia từ', profile: '3/2019'),
                            _linevertical(context),
                            _profileTasker(title: 'Công việc', profile: '320'),
                            _linevertical(context),
                            _profileTasker(
                                title: 'Đánh giá tích cực', profile: '90%'),
                          ],
                        ),
                        _titleMedal(),
                        listmedal(),
                        const SizedBox(
                          height: 28,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              child: Text(
                                'Đánh giá tiêu biểu',
                                style: AppTextTheme.mediumHeaderTitle(
                                    AppColor.text1),
                              ),
                            ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   scrollDirection: Axis.vertical,
                            //   itemCount: _listRateModel?.length,
                            //   itemBuilder: (context, index) {
                            //     return _buildComments(
                            //       comment: _listRateModel?[index]
                            //               .comments
                            //               .first
                            //               .description ??
                            //           '',
                            //       user: _listRateModel?[index]
                            //               .comments
                            //               .first
                            //               .description ??
                            //           '',
                            //       rate: _listRateModel?[index]
                            //               .comments
                            //               .first
                            //               .rating
                            //               .toString() ??
                            //           '',
                            //     );
                            //   },
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        });
  }

  Widget _profileTasker({required String title, required String profile}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: AppTextTheme.normalText(AppColor.text7),
          ),
        ),
        Text(
          profile,
          style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
        )
      ],
    );
  }

  Container _linevertical(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 42),
      width: 1,
      height: MediaQuery.of(context).size.height,
      color: AppColor.shade1,
    );
  }

  Padding _titleMedal() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, bottom: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Huy hiệu',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          Text(
            '7 huy hiệu',
            style: AppTextTheme.normalText(AppColor.primary2),
          )
        ],
      ),
    );
  }

  Widget listmedal() {
    return Container(
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 120),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          medal(),
          medal(),
          medal(),
          medal(),
          medal(),
          medal(),
        ],
      ),
    );
  }

  Padding medal() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary1,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text(
                      '10',
                      style: AppTextTheme.subText(AppColor.text2),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Nhanh nhẹn',
              style: AppTextTheme.subText(AppColor.text1),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComments({
    required String comment,
    required String user,
    required String rate,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    comment,
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                ),
                Text(
                  user,
                  style: AppTextTheme.subText(AppColor.text7),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 85),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.shade1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  SvgIcon(
                    SvgIcons.starSticker,
                    color: AppColor.primary2,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    rate,
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
