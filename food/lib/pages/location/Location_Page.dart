import 'package:flutter/material.dart';
import 'package:food/pages/location/widget/location_card.dart';
import 'package:food/pages/location/widget/maps_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  static const LatLng restaurantLocation = LatLng(30.7867, 31.0015);

  void _openMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${restaurantLocation.latitude},${restaurantLocation.longitude}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // صورة خلفية
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/image/location.jpeg', fit: BoxFit.cover),
          ),

          Opacity(
            opacity: 0.85,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: restaurantLocation,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('restaurant'),
                  position: restaurantLocation,
                  infoWindow: InfoWindow(title: 'Our Restaurant'),
                ),
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // بطاقة المعلومات
          const Positioned(
            top: 180,
            left: 20,
            right: 20,
            child: LocationCard(),
          ),

          // زر العودة
          Positioned(
            top: 40,
            left: 10,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.redAccent,
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          // زر عرض الموقع أسفل الكارد
          Positioned(
            top: 420,
            left: 40,
            right: 40,
            child: MapsButton(onPressed: _openMaps),
          ),
        ],
      ),
    );
  }
}
