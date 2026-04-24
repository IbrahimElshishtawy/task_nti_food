import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isNavVisible = true.obs;

  late final ScrollController homeScrollController;
  double _lastHomeOffset = 0;

  @override
  void onInit() {
    super.onInit();
    homeScrollController = ScrollController();
    homeScrollController.addListener(_handleHomeScroll);
  }

  void changeTab(int index) {
    if (index == currentIndex.value) {
      if (index == 0 && homeScrollController.hasClients) {
        homeScrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      }
      return;
    }

    currentIndex.value = index;
    isNavVisible.value = true;
  }

  void showNav() {
    isNavVisible.value = true;
  }

  void _handleHomeScroll() {
    if (!homeScrollController.hasClients || currentIndex.value != 0) return;

    final offset = homeScrollController.offset;
    final delta = offset - _lastHomeOffset;
    if (offset < 80) {
      isNavVisible.value = true;
    } else if (delta > 8) {
      isNavVisible.value = false;
    } else if (delta < -8) {
      isNavVisible.value = true;
    }
    _lastHomeOffset = offset;
  }

  @override
  void onClose() {
    homeScrollController.removeListener(_handleHomeScroll);
    homeScrollController.dispose();
    super.onClose();
  }
}
