import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../services/statistics_service.dart';
import '../models/statistics.dart';
import '../core/utils/number_formatter.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final _statisticsService = StatisticsService();

  DashboardStats? _dashboardStats;
  List<ViolationStats> _violationStats = [];
  List<MonthlyStats> _monthlyStats = [];
  Map<String, int>? _timeDistribution;
  bool _isLoading = true;
  String _selectedPeriod = 'วันนี้';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final results = await Future.wait([
      _statisticsService.getDashboardStats(),
      _statisticsService.getViolationStats(),
      _statisticsService.getMonthlyStats(),
      _statisticsService.getTimeDistribution(),
    ]);

    if (mounted) {
      setState(() {
        _dashboardStats = results[0].data as DashboardStats?;
        _violationStats =
            (results[1].data as List?)?.cast<ViolationStats>() ?? [];
        _monthlyStats = (results[2].data as List?)?.cast<MonthlyStats>() ?? [];
        _timeDistribution = results[3].data as Map<String, int>?;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text(AppStrings.statistics), elevation: 0),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPeriodSelector(),
                    const SizedBox(height: 20),
                    if (_dashboardStats != null) ...[
                      _buildStatCard(
                        AppStrings.totalVehicles,
                        NumberFormatter.formatNumber(
                          _dashboardStats!.totalVehicles,
                        ),
                        Icons.directions_car,
                        AppColors.info,
                        '+12.5%',
                      ),
                      const SizedBox(height: 12),
                      _buildStatCard(
                        AppStrings.violationVehicles,
                        '156',
                        Icons.warning,
                        AppColors.error,
                        '+8.3%',
                      ),
                      const SizedBox(height: 12),
                      _buildStatCard(
                        AppStrings.accuracy,
                        NumberFormatter.formatPercentage(
                          _dashboardStats!.accuracy,
                        ),
                        Icons.check_circle,
                        AppColors.success,
                        '+2.1%',
                      ),
                    ],
                    const SizedBox(height: 20),
                    _buildMonthlyChart(),
                    const SizedBox(height: 20),
                    _buildViolationTypeChart(),
                    const SizedBox(height: 20),
                    _buildHourlyDistribution(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['วันนี้', 'สัปดาห์', 'เดือน', 'ปี'];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: periods.map((period) {
          final isSelected = _selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = period),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String change,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              change,
              style: const TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart() {
    if (_monthlyStats.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.monthlyDetection,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 400,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < _monthlyStats.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _monthlyStats[value.toInt()].month,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: true, drawVerticalLine: false),
                barGroups: _monthlyStats.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.count.toDouble(),
                        color: AppColors.primaryBlue,
                        width: 20,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViolationTypeChart() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.violationTypeStats,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._violationStats.map(
            (stat) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildViolationBar(
                stat.type,
                stat.percentage.toInt(),
                _getViolationColor(stat.type),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViolationBar(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              '$percentage%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyDistribution() {
    if (_timeDistribution == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.hourlyDistribution,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeCard(
                'เช้า\n06:00-12:00',
                _timeDistribution!['morning']?.toString() ?? '0',
                AppColors.cardOrange,
              ),
              _buildTimeCard(
                'บ่าย\n12:00-18:00',
                _timeDistribution!['afternoon']?.toString() ?? '0',
                AppColors.info,
              ),
              _buildTimeCard(
                'เย็น\n18:00-00:00',
                _timeDistribution!['evening']?.toString() ?? '0',
                AppColors.cardPurple,
              ),
              _buildTimeCard(
                'กลางคืน\n00:00-06:00',
                _timeDistribution!['night']?.toString() ?? '0',
                AppColors.cardIndigo,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String time, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            NumberFormatter.formatCompactNumber(int.tryParse(count) ?? 0),
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Color _getViolationColor(String type) {
    switch (type) {
      case 'ขับเร็ว':
        return AppColors.error;
      case 'เก๋งไม่มี ภ.ผ.20':
        return AppColors.cardOrange;
      case 'บรรทุกน้ำหนักเกิน':
        return AppColors.info;
      default:
        return AppColors.cardPurple;
    }
  }
}
