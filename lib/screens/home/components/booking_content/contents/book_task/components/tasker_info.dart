import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../../core/base/blocs/block_state.dart';
import 'components.dart';

class TaskerInfo extends StatefulWidget {
  final String taskerId;
  final Function() onBack;
  const TaskerInfo({
    Key? key,
    required this.onBack,
    required this.taskerId,
  }) : super(key: key);

  @override
  State<TaskerInfo> createState() => _TaskerInfoState();
}

class _TaskerInfoState extends State<TaskerInfo> {
  final _taskerBloc = TaskerBloc();

  @override
  void initState() {
    _taskerBloc.fetchDataById(widget.taskerId);
    super.initState();
  }

  @override
  void dispose() {
    _taskerBloc.dispose();
    super.dispose();
  }

  final List<MedalModel> medals = [
    MedalModel.fromJson({
      'name': 'Thân thiện',
      'total': 10,
      'image': 'assets/images/medal_1.png',
    }),
    MedalModel.fromJson({
      'name': 'Vui vẻ',
      'total': 3,
      'image': 'assets/images/medal_2.png',
    }),
    MedalModel.fromJson({
      'name': 'Nhanh nhẹn',
      'total': 4,
      'image': 'assets/images/medal_3.png',
    }),
    MedalModel.fromJson({
      'name': 'Đúng giờ',
      'total': 47,
      'image': 'assets/images/medal_3.png',
    }),
    MedalModel.fromJson({
      'name': 'Đúng giờ',
      'total': 37,
      'image': 'assets/images/medal_2.png',
    }),
    MedalModel.fromJson({
      'name': 'Đúng giờ',
      'total': 17,
      'image': 'assets/images/medal_1.png',
    }),
    MedalModel.fromJson({
      'name': 'Đúng giờ',
      'total': 9,
      'image': 'assets/images/medal_1.png',
    }),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return LayoutBuilder(builder: (context, constraints) {
      return StreamBuilder(
          stream: _taskerBloc.taskerData,
          builder:
              (context, AsyncSnapshot<ApiResponse<TaskerModel?>> snapshot) {
            if (snapshot.hasData) {
              final tasker = snapshot.data!.model!;
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
                          onPressed: () {
                            widget.onBack();
                          },
                        ),
                        Center(
                          child: Text(
                            'Thông tin người làm',
                            style:
                                AppTextTheme.mediumHeaderTitle(AppColor.text1),
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
                      child: _buildContent(tasker),
                    ),
                  ),
                ],
              );
            }
            return StreamBuilder(
                stream: _taskerBloc.allDataState,
                builder: (context, state) {
                  if (!state.hasData || state.data == BlocState.fetching) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Text(
                      'Không tìm thấy thông tin người giúp việc',
                      style: AppTextTheme.normalText(AppColor.text3),
                    ),
                  );
                });
          });
    });
  }

  Widget _buildContent(TaskerModel tasker) {
    final dayJoin = formatFromInt(
      displayedFormat: 'MM/yyyy',
      value: tasker.createdTime,
      context: context,
    );
    double positiveReviews = 0;
    if (tasker.reviews.isNotEmpty) {
      positiveReviews = tasker.reviews.where((e) => e.rating > 2.5).length /
          tasker.reviews.length *
          100;
    }

    return Column(
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
        _buildReviewField(tasker),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 16),
          child: Text(
            '(${tasker.numReview} đánh giá)',
            style: AppTextTheme.normalText(AppColor.text1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _taskerDetail(
                  title: 'Tham gia từ',
                  detail: dayJoin,
                ),
                VerticalDivider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
                _taskerDetail(
                  title: 'Công việc',
                  detail: '${tasker.totalTask.length}',
                ),
                VerticalDivider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
                _taskerDetail(
                  title: 'Đánh giá tích cực',
                  detail: '${positiveReviews.ceil()}%',
                ),
              ],
            ),
          ),
        ),
        _titleMedal(),
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: tasker.medals.length,
        //   itemBuilder: (context, index) {
        //     final medal = tasker.medals[index];
        //     return _buildComments(review);
        //   },
        // ),
        SizedBox(
          height: 114,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: medals.length,
            itemBuilder: (context, index) {
              final medal = medals[index];
              return Padding(
                padding: const EdgeInsets.all(16),
                child: _buildMedal(medal),
              );
            },
          ),
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
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasker.reviews.length,
              itemBuilder: (context, index) {
                final review = tasker.reviews[index];
                return _buildComments(review);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildReviewField(TaskerModel tasker) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          ignoreGestures: true,
          allowHalfRating: true,
          initialRating: tasker.totalRating,
          minRating: 1,
          itemCount: 5,
          itemSize: 24,
          direction: Axis.horizontal,
          itemPadding: const EdgeInsets.symmetric(horizontal: 6),
          unratedColor: AppColor.primary2,
          itemBuilder: (context, index) {
            final isOutRate = tasker.totalRating.ceil() < index + 1;
            final isHalf = tasker.totalRating < 5 &&
                tasker.totalRating.ceil() == index + 1;
            return SvgIcon(
              isOutRate
                  ? SvgIcons.starOutline
                  : isHalf
                      ? SvgIcons.starHalf
                      : SvgIcons.star,
              color: AppColor.primary2,
            );
          },
          onRatingUpdate: (value) {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            tasker.totalRating.toString(),
            style: AppTextTheme.normalHeaderTitle(
              AppColor.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskerDetail({required String title, required String detail}) {
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
          detail,
          style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
        )
      ],
    );
  }

  Widget _titleMedal() {
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

  Widget _buildMedal(MedalModel medal) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primary2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    medal.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.primary1,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 8,
                  ),
                  child: Text(
                    '${medal.total}',
                    style: AppTextTheme.subText(AppColor.text2),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            medal.name,
            style: AppTextTheme.subText(AppColor.text1),
          ),
        ),
      ],
    );
  }

  Widget _buildComments(ReviewModel review) {
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
                    review.comment,
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                ),
                Text(
                  review.user.name,
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
                    size: 24,
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    review.rating.toString(),
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
