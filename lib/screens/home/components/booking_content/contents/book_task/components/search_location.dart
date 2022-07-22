import 'package:flutter/material.dart';
import 'components.dart';

class SearchLocation extends StatefulWidget {
  final Function(String) changeLocation;
  final Function() openPickLocation;
  final Function() goBack;
  final TextEditingController locationController;

  const SearchLocation({
    Key? key,
    required this.changeLocation,
    required this.openPickLocation,
    required this.goBack,
    required this.locationController,
  }) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final _controller = TextEditingController();
  late Debouncer _debounce;
  List<String> _placeList = [];
  List<String> searchHistory = [];

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _debounce = Debouncer(delayTime: const Duration(seconds: 1));
    _controller.text = widget.locationController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Row(
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
                    widget.goBack();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: widget.locationController,
                      style: TextStyle(color: AppColor.text1),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: widget.locationController.text.isNotEmpty
                                ? AppColor.primary1
                                : AppColor.text7,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: widget.locationController.text.isNotEmpty
                                ? AppColor.primary1
                                : AppColor.text7,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        suffixIcon: TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero),
                          child: SvgIcon(
                            SvgIcons.close,
                            color: AppColor.text1,
                            size: 24,
                          ),
                          onPressed: () {
                            _controller.clear();
                            widget.changeLocation(_controller.text);
                          },
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && !_placeList.contains(value)) {
                          _debounce.debounce(
                            afterDuration: () {
                              TaskBloc().getMapSuggestion(value).then((plates) {
                                setState(() {
                                  _placeList = plates;
                                });
                              }).onError((error, stackTrace) =>
                                  logDebug('map error: $error'));
                              _controller.text = value;
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                AppButtonTheme.fillRounded(
                  constraints:
                      const BoxConstraints(minHeight: 56, maxWidth: 40),
                  color: AppColor.transparent,
                  highlightColor: AppColor.white,
                  child: SvgIcon(
                    SvgIcons.map,
                    color: AppColor.primary1,
                    size: 24,
                  ),
                  onPressed: () {
                    widget.openPickLocation();
                    widget.changeLocation('');
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minHeight: 0,
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _placeList.length,
            itemBuilder: (context, index) {
              final location = _placeList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    searchHistory.insert(0, location);
                    widget.changeLocation(location);
                    widget.openPickLocation();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgIcon(
                              SvgIcons.locationOutline,
                              size: 24,
                              color: AppColor.shade5,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  location,
                                  style:
                                      AppTextTheme.normalText(AppColor.text1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lịch sử tìm kiếm',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  setState(() {
                    searchHistory.clear();
                  });
                },
                child: Text(
                  'Xóa tất cả',
                  style: AppTextTheme.normalText(AppColor.text3),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchHistory.length > 5
                ? searchHistory.length = 5
                : searchHistory.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    final locationName = searchHistory[index];
                    widget.changeLocation(locationName);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgIcon(
                              SvgIcons.locationOutline,
                              size: 24,
                              color: AppColor.shade5,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  searchHistory[index],
                                  style:
                                      AppTextTheme.normalText(AppColor.text1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            searchHistory.removeAt(index);
                          });
                        },
                        child: SvgIcon(
                          SvgIcons.close,
                          size: 24,
                          color: AppColor.text1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
