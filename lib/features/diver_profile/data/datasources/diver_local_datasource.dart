import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/diver_model.dart';

/// Abstract interface for local diver data operations
abstract class DiverLocalDataSource {
  /// Get cached diver profile
  Future<DiverModel?> getCachedDiver();

  /// Cache diver profile locally
  Future<void> cacheDiver(DiverModel diver);

  /// Clear cached diver
  Future<void> clearCache();
}

/// Implementation of DiverLocalDataSource using Hive
class DiverLocalDataSourceImpl implements DiverLocalDataSource {
  static const String _boxName = 'diver_cache';
  static const String _diverKey = 'current_diver';

  @override
  Future<DiverModel?> getCachedDiver() async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      final data = box.get(_diverKey);
      if (data == null) return null;

      return DiverModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException('Failed to get cached diver: $e');
    }
  }

  @override
  Future<void> cacheDiver(DiverModel diver) async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.put(_diverKey, diver.toJson());
    } catch (e) {
      throw CacheException('Failed to cache diver: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.delete(_diverKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }
}
