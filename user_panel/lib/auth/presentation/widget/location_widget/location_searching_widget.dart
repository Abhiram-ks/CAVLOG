import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_panel/auth/presentation/widget/location_widget/location_formalt_converter_widget.dart';
import 'package:user_panel/core/common/custom_lottie_widget.dart';
import 'package:user_panel/core/utils/image/app_images.dart';
import '../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../../../core/utils/debouncer/debouncer.dart';
import '../../provider/bloc/location_bloc/location_bloc.dart';
import '../../provider/bloc/searchlocation_bloc/serchlocaton_bloc.dart';
import '../../screen/location_screen/location_screen.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({
    super.key,
    required MapController mapController,
    required this.searchController,
    required this.widget,
    required this.debouncer,
    required this.screenHeight,
    required this.screenWidth,
  }) : _mapController = mapController;

  final MapController _mapController;
  final TextEditingController searchController;
  final LocationMapPage widget;
  final Debouncer debouncer;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return Center(
                  child: SpinKitFadingFour(
                color: AppPalette.greyClr,
                size: 26.0,
              ));
            } else if (state is LocationLoaded) {
              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: state.position,
                  onTap: (tapPosition, point) async {
                    context
                        .read<LocationBloc>()
                        .add(UpdateLocationEvent(point));
                    try {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              point.latitude, point.longitude);
                      if (placemarks.isNotEmpty) {
                        final Placemark place = placemarks.first;
                        String formatAddress =AddressFormatter.formatAddress(place);
                        searchController.text = formatAddress;
                        widget.addressController.text = formatAddress;
                      } else {
                        searchController.text ="${point.latitude}, ${point.longitude}";
                        widget.addressController.text = "${point.latitude}, ${point.longitude}";
                      }
                    } catch (e) {
                      searchController.text ="${point.latitude}, ${point.longitude}";
                      widget.addressController.text ="${point.latitude}, ${point.longitude}";
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:"https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.cavlog.app',
                    errorTileCallback: (tile, error, stackTrace) {
                    },
                    tileProvider: NetworkTileProvider(),
                    fallbackUrl: null,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: state.position,
                        child: Icon(Icons.location_pin,
                            color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is LocationError) {
              return Center(child: LottieFilesCommon.load(assetPath: LottieImages.emptyData, width: screenWidth, height: screenHeight));
            } else {
              return Center(child: Text("Tap to get location"));
            }
          },
        ),
        Positioned(
          top: 50,
          left: 10,
          right: 10,
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: 'Search location..',
                    fillColor: AppPalette.whiteClr,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppPalette.hintClr,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppPalette.hintClr,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppPalette.hintClr,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: AppPalette.blackClr),
                onChanged: (query) {
                  debouncer.run(() {
                    context
                        .read<SerchlocatonBloc>()
                        .add(SearchLocationEvent(query));
                  });
                },
              ),
              BlocBuilder<SerchlocatonBloc, SerchlocatonState>(
                builder: (context, state) {
                  if (state is SearchLocationLoaded && state.suggestions.isNotEmpty) {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 5)
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = state.suggestions[index];
                          return ListTile(
                            title: Text(suggestion['display_name']),
                            onTap: () {
                              double lat = double.parse(suggestion['lat']);
                              double lon = double.parse(suggestion['lon']);
                              searchController.text =
                                  suggestion['display_name'];
                              widget.addressController.text =
                                  suggestion['display_name'];
                              context.read<SerchlocatonBloc>().add(
                                  SelectLocationEvent(
                                      lat, lon, suggestion['display_name']));

                              Future.delayed(Duration(milliseconds: 300), () {
                                _mapController.move(LatLng(lat, lon), 15.0);
                              });
                            },
                          );
                        },
                      ),
                    );
                  }else if(state is SearchLocationError){
                    return Container(
                    width: double.infinity,
                    height: screenHeight*.06,
                    constraints: const BoxConstraints(maxHeight: 200),
                     decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 5)
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: AppPalette.hintClr,),
                            ConstantWidgets.width20(context),
                            Text(
                              'Search for "${searchController.text}"',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ButtonComponents.actionButton(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                label: 'SAVE POINT',
                onTap: () {
                  if (widget.addressController.text.isEmpty) {
                    CustomeSnackBar.show(
                        context: context,
                        title: 'Select Address!',
                        description:
                            "Oop's Make sure to update your address section before proceeding.",
                        titleClr: AppPalette.orengeClr,);
                  } else {
                    Navigator.pop(context);
                  }
                }))
      ],
    );
  }
}
