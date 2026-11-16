import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/addresses_list_panel_widget.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/map_widget.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/top_pannel_switcher_widget.dart';
import 'package:pizza_app/shared/widgets/ensure_permission.dart';

class MapWithAddressesListScreen extends StatefulWidget {
  const MapWithAddressesListScreen({super.key});

  @override
  State<MapWithAddressesListScreen> createState() =>
      _MapWithAddressesListState();
}

class _MapWithAddressesListState extends State<MapWithAddressesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cubit = context.read<AddressesCubit>();
      final ok = await ensurePermission(
        context,
        Permission.locationWhenInUse,
        deniedMessage: context.l10n.permissionDeniedLocation,
      );
      if (ok && mounted) cubit.loadUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocSelector<AddressesCubit, AddressesState, LatLng?>(
            selector: (state) => state.userLocation,
            builder: (context, target) => MapWidget(target: target),
          ),
          const TopPannelSwitcherWidget(),
          const AddressesListPanelWidget(),
        ],
      ),
    );
  }
}
