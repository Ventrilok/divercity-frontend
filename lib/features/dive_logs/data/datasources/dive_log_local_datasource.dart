import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/dive_log_model.dart';

/// Abstract interface for dive log local operations
abstract class DiveLogLocalDataSource {
  /// Get all cached dive logs for a diver
  Future<List<DiveLogModel>> getCachedDiveLogs(String diverId);

  /// Get a specific cached dive log by ID
  Future<DiveLogModel?> getCachedDiveLog(String diveLogId);

  /// Cache multiple dive logs
  Future<void> cacheDiveLogs(String diverId, List<DiveLogModel> diveLogs);

  /// Cache a single dive log
  Future<void> cacheDiveLog(DiveLogModel diveLog);

  /// Delete a cached dive log
  Future<void> deleteCachedDiveLog(String diveLogId);

  /// Clear all cached dive logs
  Future<void> clearCache();
}

/// Implementation of DiveLogLocalDataSource using Hive
class DiveLogLocalDataSourceImpl implements DiveLogLocalDataSource {
  static const String _boxName = 'dive_logs_cache';
  static const String _diveLogsKey = 'dive_logs';

  @override
  Future<List<DiveLogModel>> getCachedDiveLogs(String diverId) async {
    try {
      final box = await Hive.openBox(_boxName);
      final data = box.get('${_diveLogsKey}_$diverId');

      if (data == null) return [];

      if (data is List) {
        return data
            .map((item) => DiveLogModel.fromJson(Map<String, dynamic>.from(item as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw CacheException('Failed to get cached dive logs: $e');
    }
  }

  @override
  Future<DiveLogModel?> getCachedDiveLog(String diveLogId) async {
    try {
      final box = await Hive.openBox(_boxName);
      final data = box.get('dive_log_$diveLogId');

      if (data == null) return null;

      return DiveLogModel.fromJson(Map<String, dynamic>.from(data as Map));
    } catch (e) {
      throw CacheException('Failed to get cached dive log: $e');
    }
  }

  @override
  Future<void> cacheDiveLogs(String diverId, List<DiveLogModel> diveLogs) async {
    try {
      final box = await Hive.openBox(_boxName);
      final jsonList = diveLogs.map((log) => log.toJson()).toList();
      await box.put('${_diveLogsKey}_$diverId', jsonList);

      // Also cache individual dive logs
      for (final log in diveLogs) {
        await box.put('dive_log_${log.id}', log.toJson());
      }
    } catch (e) {
      throw CacheException('Failed to cache dive logs: $e');
    }
  }

  @override
  Future<void> cacheDiveLog(DiveLogModel diveLog) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.put('dive_log_${diveLog.id}', diveLog.toJson());
    } catch (e) {
      throw CacheException('Failed to cache dive log: $e');
    }
  }

  @override
  Future<void> deleteCachedDiveLog(String diveLogId) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.delete('dive_log_$diveLogId');
    } catch (e) {
      throw CacheException('Failed to delete cached dive log: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear dive logs cache: $e');
    }
  }
}
