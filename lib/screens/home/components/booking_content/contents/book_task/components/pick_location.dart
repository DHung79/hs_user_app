import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'components.dart';

class PickLocation extends StatefulWidget {
  final Function(String) changeLocation;
  final TextEditingController locationController;
  final Function() goBack;
  final Function({String lat, String long}) selectedLocation;
  final Function() goNext;
  const PickLocation({
    Key? key,
    required this.changeLocation,
    required this.locationController,
    required this.goBack,
    required this.selectedLocation,
    required this.goNext,
  }) : super(key: key);

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final Completer<GoogleMapController> _mapController = Completer();
  late TaskModel task;
  bool mapButton = false;
  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  CameraPosition _location = const CameraPosition(
    target: LatLng(12.27873, 109.1998974),
    zoom: 14.0,
  );
  late Debouncer _debounce;

  @override
  void initState() {
    _debounce = Debouncer(delayTime: const Duration(milliseconds: 500));
    if (widget.locationController.text.isNotEmpty) {
      locationFromAddress(widget.locationController.text).then(
        (locations) async {
          if (locations.isNotEmpty) {
            final newLocation =
                LatLng(locations[0].latitude, locations[0].longitude);
            _location = CameraPosition(target: newLocation, zoom: 14);
            final GoogleMapController controller = await _mapController.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_location));
          }
        },
      ).onError((error, stackTrace) => logDebug('error: $error'));
    }
    super.initState();
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final hasSearch = widget.locationController.text.isNotEmpty;
    return Column(
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
                    widget.changeLocation('');
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: AppButtonTheme.outlineRounded(
                      constraints: const BoxConstraints(minHeight: 48),
                      borderRadius: BorderRadius.circular(10),
                      outlineColor: AppColor.text7,
                      onPressed: () {
                        widget.goBack();
                        widget.changeLocation('');
                      },
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
                              hasSearch
                                  ? widget.locationController.text
                                  : 'Bấm hoặc kéo bản đồ để chọn địa chỉ',
                              style: AppTextTheme.normalText(
                                hasSearch ? AppColor.text1 : AppColor.text7,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                onCameraMove: (value) {
                  _location = value;
                  _debounce.debounce(
                    afterDuration: () async {
                      await placemarkFromCoordinates(
                        _location.target.latitude,
                        _location.target.longitude,
                      ).then(
                        (placemarks) {
                          if (placemarks.isNotEmpty) {
                            final dataLocation = '${placemarks[0].street}'
                                ', ${placemarks[0].locality}'
                                ', ${placemarks[0].administrativeArea}';
                            widget.changeLocation(dataLocation);
                          }
                        },
                      );
                    },
                  );
                },
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
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
                    final GoogleMapController controller =
                        await _mapController.future;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 14,
                        ),
                      ),
                    );
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
    );
  }

  Widget _actions() {
    return LayoutBuilder(builder: (context, size) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: AppButtonTheme.fillRounded(
          constraints: BoxConstraints(
            minHeight: 52,
            minWidth: size.maxWidth - 32,
          ),
          color: widget.locationController.text.isNotEmpty
              ? AppColor.primary2
              : AppColor.inactive1,
          borderRadius: BorderRadius.circular(4),
          child: Text(
            'Chọn vị trí này',
            style: AppTextTheme.headerTitle(AppColor.text2),
          ),
          onPressed: widget.locationController.text.isNotEmpty
              ? () {
                  widget.selectedLocation(
                    lat: _location.target.latitude.toString(),
                    long: _location.target.latitude.toString(),
                  );
                  widget.goNext();
                }
              : null,
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
}
