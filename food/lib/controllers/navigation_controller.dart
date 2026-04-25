import 'package:flutter/rendering.dart';
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

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward) {
        isNavVisible.value = true;
      } else if (notification.direction == ScrollDirection.reverse &&
          notification.metrics.pixels > 80) {
        isNavVisible.value = false;
      }
      return false;
    }

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      _updateNavForScroll(notification.metrics.pixels, delta);
    }

    return false;
  }

  void _handleHomeScroll() {
    if (!homeScrollController.hasClients || currentIndex.value != 0) return;

    final offset = homeScrollController.offset;
    final delta = offset - _lastHomeOffset;
    _updateNavForScroll(offset, delta);
    _lastHomeOffset = offset;
  }

  void _updateNavForScroll(double offset, double delta) {
    if (offset < 80) {
      isNavVisible.value = true;
    } else if (delta > 8) {
      isNavVisible.value = false;
    } else if (delta < -8) {
      isNavVisible.value = true;
    }
  }

  @override
  void onClose() {
    homeScrollController.removeListener(_handleHomeScroll);
    homeScrollController.dispose();
    super.onClose();
  }
}
