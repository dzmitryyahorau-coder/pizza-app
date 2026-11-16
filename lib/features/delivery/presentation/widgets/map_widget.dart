import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, this.target});

  final LatLng? target;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _mapController = MapController();

  static const _defaultCenter = LatLng(53.9, 27.56);

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final target = widget.target;
    if (target != null && target != oldWidget.target) {
      _mapController.move(target, 16);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.target ?? _defaultCenter,
        initialZoom: 15,
      ),
      children: [
        if (widget.target != null)
          MarkerLayer(
            markers: [
              Marker(
                point: widget.target!,
                width: 40,
                height: 40,
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: colors.brandColor,
                ),
              ),
            ],
          ),
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'pizza_app',
        ),
      ],
    );
  }
}
