import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_bottom_nav.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: <Widget>[
          const _ProfileSection(),
          const SizedBox(height: 18),
          _SettingsGroup(
            children: <Widget>[
              Obx(
                () => SwitchListTile(
                  value: controller.isDarkMode.value,
                  onChanged: controller.toggleTheme,
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Dark / Light theme'),
                  subtitle: Text(
                    controller.isDarkMode.value ? 'Dark mode' : 'Light mode',
                  ),
                ),
              ),
              const Divider(height: 1),
              Obx(
                () => SwitchListTile(
                  value: controller.notificationsEnabled.value,
                  onChanged: controller.toggleNotifications,
                  secondary: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Notifications'),
                  subtitle: const Text('Order updates and offers'),
                ),
              ),
              const Divider(height: 1),
              Obx(
                () => ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: const Text('Language'),
                  subtitle: Text(controller.selectedLanguage.value),
                  trailing: DropdownButton<String>(
                    value: controller.selectedLanguage.value,
                    underline: const SizedBox.shrink(),
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Arabic',
                        child: Text('Arabic'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) controller.changeLanguage(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SettingsGroup(
            children: <Widget>[
              _SettingsTile(
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                subtitle: AppConstants.defaultDeliveryLocation,
                onTap: () {},
              ),
              const Divider(height: 1),
              _SettingsTile(
                icon: Icons.credit_card_rounded,
                title: 'Payment methods',
                subtitle: 'Cash, card, wallet',
                onTap: () => Get.toNamed(AppRoutes.paymentMethods),
              ),
              const Divider(height: 1),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About App',
                subtitle: 'TasteTrail version 1.0.0',
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: AppConstants.appName,
                  applicationVersion: '1.0.0',
                  applicationLegalese:
                      'Premium food ordering demo built with GetX.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SettingsGroup(
            children: <Widget>[
              _SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                subtitle: 'End the current demo session',
                iconColor: AppColors.tomato,
                onTap: controller.logout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: .14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_rounded,
              color: colorScheme.primary,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppConstants.defaultUserName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                Text(
                  'Premium food lover',
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit profile',
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(children: children),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
