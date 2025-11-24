import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../widgets/stat_card.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/section_header.dart';
import '../services/statistics_service.dart';
import '../services/vehicle_service.dart';
import '../services/operator_service.dart';
import '../models/statistics.dart';
import '../models/vehicle.dart';
import '../models/operator.dart';
import '../core/utils/number_formatter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _statisticsService = StatisticsService();
  final _vehicleService = VehicleService();
  final _operatorService = OperatorService();

  DashboardStats? _stats;
  List<Vehicle> _recentVehicles = [];
  List<ViolationStats> _violationStats = [];
  List<DetectionData> _hourlyData = [];
  List<Operator> _topOperators = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final results = await Future.wait([
      _statisticsService.getDashboardStats(),
      _vehicleService.getRecentVehicles(limit: 3),
      _statisticsService.getViolationStats(),
      _statisticsService.getHourlyDetection(),
      _operatorService.getTopOperators(limit: 3),
    ]);

    if (mounted) {
      setState(() {
        _stats = results[0].data as DashboardStats?;
        _recentVehicles = (results[1].data as List?)?.cast<Vehicle>() ?? [];
        _violationStats =
            (results[2].data as List?)?.cast<ViolationStats>() ?? [];
        _hourlyData = (results[3].data as List?)?.cast<DetectionData>() ?? [];
        _topOperators = (results[4].data as List?)?.cast<Operator>() ?? [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildStatsGrid(),
                      _buildVehicleList(),
                      _buildDetectionChart(),
                      _buildOperatorList(),
                      _buildViolationChart(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.lprMonitor,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          const Text(
            AppStrings.systemTracking,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    if (_stats == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
        children: [
          StatCard(
            title: AppStrings.totalCount,
            value: NumberFormatter.formatNumber(_stats!.totalVehicles),
            color: AppColors.cardTeal,
            icon: Icons.directions_car,
          ),
          StatCard(
            title: AppStrings.today,
            value: _stats!.todayCount.toString(),
            color: AppColors.cardOrange,
            icon: Icons.flag,
          ),
          StatCard(
            title: AppStrings.thisMonth,
            value: _stats!.monthCount.toString(),
            color: AppColors.cardRed,
            icon: Icons.trending_up,
          ),
          StatCard(
            title: AppStrings.accuracy,
            value: NumberFormatter.formatPercentage(_stats!.accuracy),
            color: AppColors.cardPurple,
            icon: Icons.check_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          SectionHeader(title: AppStrings.recentVehicles, onViewAll: () {}),
          const SizedBox(height: 12),
          ..._recentVehicles.asMap().entries.map((entry) {
            final index = entry.key;
            final vehicle = entry.value;
            return Column(
              children: [
                if (index > 0) const Divider(height: 24),
                VehicleCard(
                  plate: vehicle.plateNumber,
                  type: vehicle.type.value,
                  violation: vehicle.violationType ?? 'ปกติ',
                  isNormal: !vehicle.isViolation,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetectionChart() {
    if (_hourlyData.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.all(16),
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
            AppStrings.detectionByTime,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
                  },
                ),
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
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < _hourlyData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _hourlyData[value.toInt()].time,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                              ),
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
                      interval: 50,
                      reservedSize: 40,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (_hourlyData.length - 1).toDouble(),
                minY: 0,
                maxY: 200,
                lineBarsData: [
                  LineChartBarData(
                    spots: _hourlyData.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.count.toDouble(),
                      );
                    }).toList(),
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primaryBlue.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          SectionHeader(title: AppStrings.operatorCount, onViewAll: () {}),
          const SizedBox(height: 12),
          ..._topOperators.asMap().entries.map((entry) {
            final index = entry.key;
            final operator = entry.value;
            return Column(
              children: [
                if (index > 0) const Divider(height: 24),
                _buildOperatorItem(operator),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOperatorItem(Operator operator) {
    final statusColor = operator.isTopPerformer ? Colors.green : Colors.red;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green[100],
          child: const Icon(Icons.person, color: Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                operator.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    NumberFormatter.formatNumber(operator.detectionCount),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    NumberFormatter.formatPercentage(operator.accuracy),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            operator.rank.toString(),
            style: TextStyle(
              fontSize: 14,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViolationChart() {
    if (_violationStats.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.all(16),
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
            AppStrings.violationTypes,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: _violationStats.map((stat) {
                        final color = _getViolationColor(stat.type);
                        return PieChartSectionData(
                          color: color,
                          value: stat.percentage,
                          title: '${stat.percentage.toInt()}%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _violationStats
                        .map(
                          (stat) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildLegendItem(
                              stat.type,
                              _getViolationColor(stat.type),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getViolationColor(String type) {
    switch (type) {
      case 'ขับเร็ว':
        return AppColors.primaryBlue;
      case 'เก๋งไม่มี ภ.ผ.20':
        return AppColors.cardOrange;
      case 'บรรทุกน้ำหนักเกิน':
        return AppColors.cardGreen;
      default:
        return AppColors.cardRed;
    }
  }
}
