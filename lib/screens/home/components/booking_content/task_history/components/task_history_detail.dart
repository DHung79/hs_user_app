import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/task/task.dart';
import '../../../../../../core/tasker/tasker.dart';
import '../../../../../../core/user/user.dart';
import '../../../../../../main.dart';
import '../../../../../../theme/validator_text.dart';
import '../../../../../../widgets/task_widget/task_widget.dart';
import '../../book_task/components/components.dart';
import 'rating_dialog.dart';

class TaskHistoryDetail extends StatefulWidget {
  final TaskModel task;
  final UserModel user;
  final Function()? onChangeContent;
  const TaskHistoryDetail({
    Key? key,
    required this.task,
    required this.user,
    this.onChangeContent,
  }) : super(key: key);

  @override
  State<TaskHistoryDetail> createState() => _TaskHistoryDetailState();
}

class _TaskHistoryDetailState extends State<TaskHistoryDetail> {
  bool _isShowCheckList = false;
  final _taskBloc = TaskBloc();

  @override
  void initState() {
    JTToast.init(context);
    _isShowCheckList = widget.task.checkList.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() {
    _taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                constraints: const BoxConstraints(minHeight: 56),
                color: AppColor.transparent,
                highlightColor: AppColor.white,
                child: SvgIcon(
                  SvgIcons.arrowBack,
                  size: 24,
                  color: AppColor.black,
                ),
                onPressed: () {
                  navigateTo(taskHistoryRoute);
                },
              ),
              Center(
                child: Text(
                  'Chi tiết công việc',
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
                if (widget.task.tasker.id.isNotEmpty) _profile(),
                _userProfile(),
                _detailTask(),
                _paymentField(),
                if (widget.task.status == 2)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _actions(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipOval(
                  child: widget.task.tasker.avatar.isNotEmpty
                      ? Image.network(
                          widget.task.tasker.avatar,
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
              const SizedBox(
                width: 16,
              ),
              InkWell(
                highlightColor: AppColor.white,
                splashColor: AppColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        widget.task.tasker.name,
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Xem thêm',
                          style: AppTextTheme.mediumBodyText(AppColor.primary2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Transform.rotate(
                            angle: 180 * pi / 180,
                            child: SvgIcon(
                              SvgIcons.arrowBack,
                              color: AppColor.primary2,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: widget.onChangeContent,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: AppColor.shadow.withOpacity(0.16),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      SvgIcons.starSticker,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        widget.task.tasker.totalRating.toString(),
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thông tin của bạn',
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Text(
              widget.task.address.subName,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.locationOutline,
              text: widget.task.address.name,
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.viewDetails,
              text: widget.task.address.location,
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.telephone,
              text: widget.user.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem({
    required SvgIconData? icon,
    required String text,
  }) {
    return Row(
      children: [
        SvgIcon(
          icon,
          color: AppColor.shade5,
          size: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: AppTextTheme.normalText(AppColor.text1),
        )
      ],
    );
  }

  Widget _detailTask() {
    final price =
        NumberFormat('#,##0 VND', 'vi').format(widget.task.totalPrice);
    final startTime = formatFromInt(
      displayedFormat: 'HH:mm',
      value: widget.task.startTime,
      context: context,
    );
    final endTime = formatFromInt(
      displayedFormat: '- HH:mm',
      value: widget.task.endTime,
      context: context,
    );
    final date = formatFromInt(
      displayedFormat: 'E, dd/MM/yyyy',
      value: widget.task.date,
      context: context,
    );
    final hadDone = widget.task.checkList
        .where(
          (e) => e.status == true,
        )
        .length;
    final double angle = _isShowCheckList ? 180 : 0;
    final optionType =
        getOptionType(widget.task.service.optionType).toLowerCase();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiết công việc',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.shade1,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: Text(
                    getStatusName(widget.task),
                    style: AppTextTheme.mediumBodyText(
                      colorStatus(
                        index: widget.task.status,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.task.status == 3) _buildFailReason(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            _detailItem(
                icon: SvgIcons.time,
                text:
                    '${widget.task.selectedOption.quantity} $optionType, $startTime $endTime'),
            const SizedBox(
              height: 10,
            ),
            _detailItem(
              icon: SvgIcons.calendar,
              text: date,
            ),
            const SizedBox(
              height: 10,
            ),
            _detailItem(
              icon: SvgIcons.dollar,
              text: price,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Text(
              'Ghi chú cho người giúp việc',
              style: AppTextTheme.mediumBodyText(AppColor.primary1),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.shade1,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.task.note,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh sách nhắc việc',
                  style: AppTextTheme.mediumBodyText(AppColor.primary1),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                          '$hadDone/${widget.task.checkList.length}',
                          style: AppTextTheme.normalText(AppColor.text3),
                        ),
                        Transform.rotate(
                          angle: angle * pi / 180,
                          child: SvgIcon(
                            SvgIcons.expandMore,
                            color: AppColor.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isShowCheckList = !_isShowCheckList;
                    });
                  },
                ),
              ],
            ),
            if (_isShowCheckList)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.shade1,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.task.checkList.length,
                    itemBuilder: (context, index) {
                      final checkItem = widget.task.checkList[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              checkItem.status
                                  ? SvgIcon(
                                      SvgIcons.checkBox,
                                      size: 24,
                                      color: AppColor.shade9,
                                    )
                                  : SvgIcon(
                                      SvgIcons.checkBoxOutlineBlank,
                                      size: 24,
                                      color: AppColor.others1,
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  checkItem.name,
                                  style:
                                      AppTextTheme.normalText(AppColor.text1),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            if (widget.task.tasker.id.isNotEmpty && widget.task.status > 1)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Divider(
                      color: AppColor.shade1,
                      height: 1,
                    ),
                  ),
                  Text(
                    'Chụp hình thành quả',
                    style: AppTextTheme.mediumBodyText(AppColor.primary1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _buildImages(
                      title: 'Trước',
                      images: widget.task.listPicturesBefore,
                    ),
                  ),
                  _buildImages(
                    title: 'Sau',
                    images: widget.task.listPicturesAfter,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailReason() {
    final cancelTime = formatFromInt(
      displayedFormat: 'HH:mm - dd/MM/yyyy',
      value: widget.task.updatedTime,
      context: context,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(
            color: AppColor.shade1,
            height: 1,
          ),
        ),
        Wrap(
          runSpacing: 12,
          children: [
            _buildFailItem(
              title: 'Lý do hủy',
              text: 'Bận việc đột xuất',
            ),
            _buildFailItem(
              title: 'Thời điểm hủy',
              text: cancelTime,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFailItem({required String title, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextTheme.normalText(AppColor.primary2),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              text,
              style: AppTextTheme.normalText(AppColor.others1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImages({
    required String title,
    required List<String> images,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.mediumBodyText(AppColor.text1),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              final url = images[index];
              final isLast = index != images.length - 1;
              return Padding(
                padding: EdgeInsets.only(right: isLast ? 16 : 0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _paymentField() {
    final price =
        NumberFormat('#,##0 VND', 'vi').format(widget.task.totalPrice);
    final paymentStatus = widget.task.status == 2 ? 'Thành công' : 'Thất bại';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.text2,
            boxShadow: [
              BoxShadow(
                  color: AppColor.shadow.withOpacity(0.16),
                  blurRadius: 16,
                  blurStyle: BlurStyle.outer)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hình thức thanh toán',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.shade1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Text(
                    paymentStatus,
                    style: AppTextTheme.mediumBodyText(
                      colorStatus(
                        index: widget.task.status,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            widget.task.status == 2
                ? Wrap(
                    runSpacing: 12,
                    children: [
                      _detailItem(
                        icon: SvgIcons.wallet,
                        text: 'Tiền mặt',
                      ),
                      _detailItem(
                        icon: SvgIcons.dollar,
                        text: price,
                      ),
                      _detailItem(
                        icon: SvgIcons.tag,
                        text: 'JOYTECH07',
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: _buildFailItem(
                      title: 'Phí hủy',
                      text: price,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _actions() {
    return AppButtonTheme.fillRounded(
      constraints: const BoxConstraints(
        minHeight: 52,
      ),
      borderRadius: BorderRadius.circular(4),
      color: AppColor.primary2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            SvgIcons.starOutlineRounded,
            color: AppColor.white,
            size: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Đánh giá',
              style: AppTextTheme.headerTitle(AppColor.white),
            ),
          ),
        ],
      ),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black12,
          builder: (BuildContext context) {
            final editModel = EditReviewModel.fromModel(null);
            final controller = TextEditingController();
            return RatingDialog(
              contentHeader: Column(
                children: [
                  Center(
                    child: RatingBar.builder(
                      initialRating: editModel.rating,
                      minRating: 1,
                      itemCount: 5,
                      itemSize: 48,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                      unratedColor: AppColor.primary2,
                      itemBuilder: (context, index) {
                        final isOutRate = editModel.rating < index + 1;
                        return SvgIcon(
                          isOutRate ? SvgIcons.starOutline : SvgIcons.star,
                          color: AppColor.primary2,
                        );
                      },
                      onRatingUpdate: (value) {
                        setState(() {
                          editModel.rating = value;
                        });
                      },
                    ),
                  ),
                  TextAreaInput(
                    controller: controller,
                    maxLines: 5,
                    hintText: 'Nhập đánh giá',
                    hintStyle: AppTextTheme.normalText(AppColor.text7),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  editModel.comment = controller.text;
                });
                _ratingTasker(editModel);
              },
            );
          },
        );
      },
    );
  }

  _ratingTasker(EditReviewModel editModel) {
    TaskerBloc()
        .ratingTasker(
      editModel: editModel,
      taskId: widget.task.id,
    )
        .then((value) {
      Navigator.of(context).pop();
      navigateTo(taskHistoryRoute);
      JTToast.successToast(message: 'Đã đánh giá');
    }).onError((ApiError error, stackTrace) {
      logDebug('onError: ${error.errorMessage}');
      JTToast.errorToast(message: showError(error.errorCode, context));
    }).catchError(
      (error, stackTrace) {
        logDebug('catchError: $error');
      },
    );
  }
}
