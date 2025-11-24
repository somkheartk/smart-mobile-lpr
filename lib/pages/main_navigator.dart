import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_colors.dart';
import 'dashboard_page.dart';
import 'camera_page.dart';
import 'statistics_page.dart';
import 'vehicle_list_page.dart';
import 'settings_page.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const CameraPage(),
    const StatisticsPage(),
    const VehicleListPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: AppStrings.statistics,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: AppStrings.camera,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: AppStrings.vehicleList,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}
