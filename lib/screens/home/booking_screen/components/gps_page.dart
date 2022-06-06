import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:http/http.dart' as http;

import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

class GoogleSearchPlacesApi extends StatefulWidget {
  @override
  _GoogleSearchPlacesApiState createState() => _GoogleSearchPlacesApiState();
}

class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {
  final _controller = TextEditingController();
  final PageState _pageState = PageState();
  Timer? _debounce;

  List<dynamic> _placeList = [];
  bool _haveData = false;

  void getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kPLACESAPIKEY';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
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
            child: content(),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _appBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateTo(chooseLocationRoute);
                    setState(() {
                      dataLocation = _placeList[index]["description"];
                      logDebug(dataLocation);
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
                                SvgIcons.epLocation,
                                size: 24,
                                color: AppColor.shade5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    _placeList[index]["description"],
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
                            onPressed: () {},
                            child: SvgIcon(
                              SvgIcons.close,
                              size: 24,
                              color: AppColor.text1,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: AppColor.text2,
      elevation: 16,
      shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
      flexibleSpace: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextButton(
              style: TextButton.styleFrom(
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero),
              child: SvgIcon(
                SvgIcons.arrowBack,
                color: AppColor.text1,
                size: 24,
              ),
              onPressed: () {
                navigateTo(posttaskRoute);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _haveData = true;
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      getSuggestion(value);
                    });
                  } else {
                    _haveData = false;
                  }
                },
                controller: _controller,
                style: TextStyle(color: AppColor.text1),
                decoration: InputDecoration(
                  errorStyle: AppTextTheme.subText(AppColor.others1),
                  filled: true,
                  fillColor: Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: _haveData ? AppColor.primary1 : AppColor.text7,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: _haveData ? AppColor.primary1 : AppColor.text7,
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
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  navigateTo(chooseLocationRoute);
                },
                child: SvgIcon(
                  SvgIcons.map1,
                  color: AppColor.primary1,
                  size: 24,
                )),
          )
        ],
      ),
    );
  }
}

void _fetchDataOnPage() {}
