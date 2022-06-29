import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/gps_page.dart';
import 'package:hs_user_app/widgets/debouncer.dart';
import '../../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../../core/task/model/task_model.dart';
import '../../../../../core/user/model/user_model.dart';
import '../../../../../theme/svg_constants.dart';
import '../../../../../widgets/jt_indicator.dart';
import '../../../../layout_template/content_screen.dart';

final chooseLocationKey = GlobalKey<_ChooseLocationState>();

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final PageState _pageState = PageState();
  late GoogleMapController _mapController;
  late TaskModel task;
  String? nameAddressChoose = '';
  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best, distanceFilter: 0);

  CameraPosition _location = const CameraPosition(
    target: LatLng(12.27873, 109.1998974),
    zoom: 12.0,
  );
  late Marker _selectedPlate;
  late Debouncer _debounce;

  @override
  void initState() {
    _debounce = Debouncer(delayTime: const Duration(milliseconds: 500));
    _debounce.debounce(
      afterDuration: () async {
        await placemarkFromCoordinates(
          _selectedPlate.position.latitude,
          _selectedPlate.position.longitude,
        ).then(
          (placemarks) {
            if (placemarks.isNotEmpty) {
              final dataLocation = '${placemarks[0].street}'
                  ', ${placemarks[0].locality}'
                  ', ${placemarks[0].administrativeArea}';
              setState(() {
                nameAddressChoose = dataLocation;
              });
            }
          },
        );
      },
    );
    logDebug(googleSearchPlacesApiKey.currentState);
    if (googleSearchPlacesApiKey.currentState != null) {
      nameAddressChoose = googleSearchPlacesApiKey.currentState?.nameAddress;
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());

    _selectedPlate = Marker(
      markerId: const MarkerId('selectedPlate'),
      position: _location.target,
    );

    locationFromAddress(nameAddressChoose!).then(
      (locations) {
        if (locations.isNotEmpty) {
          final newLocation =
              LatLng(locations[0].latitude, locations[0].longitude);
          _selectedPlate = Marker(
            markerId: const MarkerId('selectedPlate'),
            position: newLocation,
          );
          _location = CameraPosition(target: newLocation, zoom: 20);
        } else {}
      },
    );
   
    logDebug('nameAddressChoose: $nameAddressChoose');
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _debounce.dispose();

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
            child: snapshot.hasData
                ? _buildContent(snapshot)
                : const JTIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<UserModel> snapshot) {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _appBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onCameraMove: (value) {
                    setState(
                      () {
                        _selectedPlate = Marker(
                          markerId: const MarkerId('selectedPlate'),
                          position: LatLng(
                            value.target.latitude,
                            value.target.longitude,
                          ),
                        );
                      },
                    );
                    _debounce.debounce(
                      afterDuration: () async {
                        await placemarkFromCoordinates(
                          _selectedPlate.position.latitude,
                          _selectedPlate.position.longitude,
                        ).then(
                          (placemarks) {
                            if (placemarks.isNotEmpty) {
                              final dataLocation = '${placemarks[0].street}'
                                  ', ${placemarks[0].locality}'
                                  ', ${placemarks[0].administrativeArea}';
                              setState(() {
                                nameAddressChoose = dataLocation;
                              });
                            }
                          },
                        );
                      },
                    );
                  },
                  onMapCreated: _onMapCreated,
                  minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
                  initialCameraPosition: _location,
                  scrollGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  indoorViewEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  trafficEnabled: true,
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: AppColor.text2,
                    child: SvgIcon(
                      SvgIcons.myLocation,
                      color: AppColor.primary2,
                      size: 24,
                    ),
                    onPressed: () async {
                      await _gpsService();
                      Position position = await _determinePosition();

                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14),
                        ),
                      );

                      setState(() async {});
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Icon(
                      Icons.location_on,
                      color: AppColor.others1,
                      size: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _actions(),
        ],
      ),
    );
  }

  Widget _actions() {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        color: AppColor.text2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColor.primary2,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () async {
              setState(() {
                positionTask = {
                  'lat': _selectedPlate.position.latitude.toString(),
                  'long': _selectedPlate.position.longitude.toString(),
                };
              });
              navigateTo(pickTypeHomeRoute);
            },
            child: Text(
              'Chọn vị trí này',
              style: AppTextTheme.headerTitle(AppColor.text2),
            ),
          ),
        ),
      );
    });
  }

  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      return null;
    } else {
      return true;
    }
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: AppColor.text2,
      elevation: 0.16,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  navigateTo(gpsPageRoute);
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColor.text7,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgIcon(
                            SvgIcons.search,
                            color: AppColor.text1,
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            nameAddressChoose!,
                            style: AppTextTheme.normalText(AppColor.text1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}

void _fetchDataOnPage() {}
