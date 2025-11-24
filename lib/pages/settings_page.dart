import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../services/auth_service.dart';
import '../core/utils/ui_helpers.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentUser = authService.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text(AppStrings.settings), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(currentUser?.fullName ?? AppStrings.admin),
            const SizedBox(height: 20),
            Text(
              AppStrings.generalSettings,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _buildSettingsSection([
              _buildSettingItem(
                Icons.notifications_outlined,
                AppStrings.notifications,
                AppStrings.notificationDesc,
                () {},
              ),
              _buildSettingItem(
                Icons.language,
                AppStrings.language,
                AppStrings.thai,
                () {},
              ),
              _buildSettingItem(
                Icons.dark_mode_outlined,
                AppStrings.theme,
                AppStrings.lightMode,
                () {},
              ),
            ]),
            const SizedBox(height: 20),
            Text(
              AppStrings.systemSettings,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _buildSettingsSection([
              _buildSettingItem(
                Icons.camera_alt_outlined,
                AppStrings.cameraSettings,
                AppStrings.cameraDesc,
                () {},
              ),
              _buildSettingItem(
                Icons.upload_outlined,
                AppStrings.exportData,
                AppStrings.exportDesc,
                () {},
              ),
              _buildSettingItem(
                Icons.cloud_sync_outlined,
                AppStrings.syncData,
                'อัปเดตล่าสุด: 5 นาทีที่แล้ว',
                () {},
              ),
            ]),
            const SizedBox(height: 20),
            Text(
              AppStrings.about,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _buildSettingsSection([
              _buildSettingItem(
                Icons.info_outline,
                AppStrings.aboutApp,
                AppStrings.version,
                () {},
              ),
              _buildSettingItem(
                Icons.privacy_tip_outlined,
                AppStrings.privacyPolicy,
                AppStrings.privacyDesc,
                () {},
              ),
              _buildSettingItem(
                Icons.description_outlined,
                AppStrings.termsOfService,
                AppStrings.termsDesc,
                () {},
              ),
            ]),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(AppStrings.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String name) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
            child: const Icon(
              Icons.person,
              size: 40,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'admin@lpr.com',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryBlue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await DialogHelper.showConfirmDialog(
      context,
      title: 'ออกจากระบบ',
      message: 'คุณต้องการออกจากระบบใช่หรือไม่?',
      confirmText: 'ออกจากระบบ',
      cancelText: 'ยกเลิก',
    );

    if (confirmed == true && context.mounted) {
      LoadingOverlay.show(context);

      await AuthService().logout();

      LoadingOverlay.hide();

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    }
  }
}
