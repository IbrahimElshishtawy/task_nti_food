import 'package:flutter/material.dart';
import 'package:food/pages/location/Location_Page.dart';
import 'package:food/pages/wheel/wheel_page.dart';

import 'action_button.dart';

class HomeActions extends StatelessWidget {
  final VoidCallback toggleMenu;
  final AnimationController wheelController;

  const HomeActions({
    super.key,
    required this.toggleMenu,
    required this.wheelController,
  });

  void goToWheelPage(BuildContext ctx) {
    wheelController.stop();
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (_) => const WheelPage()),
    ).then((_) => wheelController.repeat());
  }

  void goToLocationPage(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => const LocationPage(),
      ), // ✅ الانتقال لصفحة الموقع
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          actionButton(Icons.restaurant_menu, "Menu", toggleMenu),
          actionButton(
            Icons.location_on,
            "Location",
            () => goToLocationPage(context),
          ), // ✅ تحديث الضغط
          actionButton(Icons.event_seat, "Reserve Table", () {}),
          Column(
            children: [
              InkWell(
                onTap: () => goToWheelPage(context),
                borderRadius: BorderRadius.circular(40),
                child: RotationTransition(
                  turns: wheelController,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    child: const Icon(
                      Icons.autorenew,
                      color: Colors.redAccent,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Check your luck",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
