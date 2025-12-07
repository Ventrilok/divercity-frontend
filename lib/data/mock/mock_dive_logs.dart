import '../../features/dive_logs/data/models/dive_log.dart';

/// Mock dive log data for prototype
class MockDiveLogs {
  static final List<DiveLog> diveLogs = [
    DiveLog(
      id: 'dive-001',
      diveSite: 'Blue Hole',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 15, 10, 30),
      maxDepth: 28.5,
      duration: 45,
      waterTemperature: 24.0,
      airTemperature: 28.0,
      entryPressure: 200.0,
      exitPressure: 50.0,
      gasMix: 'Air (21% O2)',
      notes: 'Amazing visibility! Saw a large grouper and some lionfish. The arch was spectacular.',
    ),
    DiveLog(
      id: 'dive-002',
      diveSite: 'The Bells',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 16, 14, 00),
      maxDepth: 26.0,
      duration: 42,
      waterTemperature: 23.5,
      airTemperature: 27.5,
      entryPressure: 200.0,
      exitPressure: 60.0,
      gasMix: 'Air (21% O2)',
      notes: 'Strong current at depth. Beautiful coral formations and schools of glassfish.',
    ),
    DiveLog(
      id: 'dive-003',
      diveSite: 'Canyon',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 17, 11, 15),
      maxDepth: 30.0,
      duration: 38,
      waterTemperature: 24.5,
      airTemperature: 29.0,
      entryPressure: 200.0,
      exitPressure: 45.0,
      gasMix: 'Air (21% O2)',
      notes: 'Narrow passages, thrilling dive! The canyon walls were impressive.',
    ),
    DiveLog(
      id: 'dive-004',
      diveSite: 'Eel Garden',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 18, 9, 45),
      maxDepth: 18.0,
      duration: 52,
      waterTemperature: 24.0,
      airTemperature: 26.0,
      entryPressure: 200.0,
      exitPressure: 70.0,
      gasMix: 'Air (21% O2)',
      notes: 'Shallow dive, perfect for relaxation. Hundreds of garden eels swaying in the current.',
    ),
    DiveLog(
      id: 'dive-005',
      diveSite: 'Great Barrier Reef',
      location: 'Cairns, Australia',
      diveDate: DateTime(2024, 10, 5, 13, 30),
      maxDepth: 22.0,
      duration: 48,
      waterTemperature: 26.0,
      airTemperature: 30.0,
      entryPressure: 200.0,
      exitPressure: 55.0,
      gasMix: 'Air (21% O2)',
      notes: 'World-class reef diving. Saw turtles, reef sharks, and incredible coral diversity.',
    ),
    DiveLog(
      id: 'dive-006',
      diveSite: 'Sipadan Island',
      location: 'Sabah, Malaysia',
      diveDate: DateTime(2024, 9, 20, 10, 00),
      maxDepth: 32.0,
      duration: 40,
      waterTemperature: 28.0,
      airTemperature: 31.0,
      entryPressure: 200.0,
      exitPressure: 48.0,
      gasMix: 'Nitrox 32',
      notes: 'Barracuda Point - massive school of barracudas! Also spotted hammerhead sharks.',
    ),
    DiveLog(
      id: 'dive-007',
      diveSite: 'Cenote Dos Ojos',
      location: 'Tulum, Mexico',
      diveDate: DateTime(2024, 8, 12, 11, 30),
      maxDepth: 10.0,
      duration: 55,
      waterTemperature: 25.0,
      airTemperature: 32.0,
      entryPressure: 200.0,
      exitPressure: 75.0,
      gasMix: 'Air (21% O2)',
      notes: 'Crystal clear freshwater cenote. Stunning light rays and rock formations.',
    ),
    DiveLog(
      id: 'dive-008',
      diveSite: 'SS Thistlegorm',
      location: 'Red Sea, Egypt',
      diveDate: DateTime(2024, 7, 8, 8, 00),
      maxDepth: 29.0,
      duration: 44,
      waterTemperature: 26.0,
      airTemperature: 35.0,
      entryPressure: 200.0,
      exitPressure: 52.0,
      gasMix: 'Nitrox 32',
      notes: 'Historic WWII wreck. Explored the cargo holds with motorcycles and trucks.',
    ),
    DiveLog(
      id: 'dive-009',
      diveSite: 'Manta Point',
      location: 'Nusa Penida, Bali',
      diveDate: DateTime(2024, 6, 14, 15, 00),
      maxDepth: 16.0,
      duration: 50,
      waterTemperature: 27.0,
      airTemperature: 29.0,
      entryPressure: 200.0,
      exitPressure: 68.0,
      gasMix: 'Air (21% O2)',
      notes: 'Three manta rays circling the cleaning station! Incredible experience.',
    ),
    DiveLog(
      id: 'dive-010',
      diveSite: 'Shark Point',
      location: 'Phuket, Thailand',
      diveDate: DateTime(2024, 5, 22, 12, 15),
      maxDepth: 24.0,
      duration: 46,
      waterTemperature: 28.5,
      airTemperature: 33.0,
      entryPressure: 200.0,
      exitPressure: 58.0,
      gasMix: 'Air (21% O2)',
      notes: 'Leopard sharks resting on the sandy bottom. Beautiful soft corals.',
    ),
  ];

  /// Get all dive logs sorted by date (newest first)
  static List<DiveLog> getAllDiveLogs() {
    final sorted = List<DiveLog>.from(diveLogs);
    sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
    return sorted;
  }

  /// Get recent dive logs (last 3)
  static List<DiveLog> getRecentDiveLogs({int count = 3}) {
    final sorted = getAllDiveLogs();
    return sorted.take(count).toList();
  }

  /// Get most recent dive
  static DiveLog? getMostRecentDive() {
    if (diveLogs.isEmpty) return null;
    return getAllDiveLogs().first;
  }
}
