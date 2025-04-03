import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_panel/core/utils/debouncer/debouncer.dart';
import '../../../domain/usecases/get_location_usecase.dart';
import '../../provider/bloc/location_bloc/location_bloc.dart';
import '../../widget/location_widget/location_searching_widget.dart';

class LocationMapPage extends StatefulWidget {
  final TextEditingController addressController;

  const LocationMapPage({super.key, required this.addressController});

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  final TextEditingController searchController = TextEditingController();
  final MapController _mapController = MapController();
  late Debouncer debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;

      return Scaffold(
         resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => LocationBloc(GetLocationUseCase())
            ..add(GetCurrentLocationEvent()),
          child: LocationMapWidget(
              mapController: _mapController,
              searchController: searchController,
              widget: widget,
              debouncer: debouncer,
              screenHeight: screenHeight,
              screenWidth: screenWidth),
        ),
      );
    });
  }
}
