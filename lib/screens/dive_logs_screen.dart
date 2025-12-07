import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/ocean_background.dart';
import '../widgets/dive_card.dart';
import '../widgets/custom_app_bar.dart';
import '../providers/dive_log_provider.dart';

/// Dive logs list screen - displays all dive logs with search/filter
class DiveLogsScreen extends ConsumerStatefulWidget {
  const DiveLogsScreen({super.key});

  @override
  ConsumerState<DiveLogsScreen> createState() => _DiveLogsScreenState();
}

class _DiveLogsScreenState extends ConsumerState<DiveLogsScreen> {
  String _searchQuery = '';
  String _sortBy = 'date'; // 'date', 'depth', 'duration'

  @override
  Widget build(BuildContext context) {
    final allDives = ref.watch(diveLogProvider);

    // Filter and sort dives
    var filteredDives = allDives.where((dive) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return dive.diveSite.toLowerCase().contains(query) ||
          dive.location.toLowerCase().contains(query) ||
          dive.notes?.toLowerCase().contains(query) == true;
    }).toList();

    // Sort dives
    filteredDives.sort((a, b) {
      switch (_sortBy) {
        case 'depth':
          return b.maxDepth.compareTo(a.maxDepth);
        case 'duration':
          return b.duration.compareTo(a.duration);
        case 'date':
        default:
          return b.diveDate.compareTo(a.diveDate);
      }
    });

    return Scaffold(
      appBar: OceanAppBar(
        title: 'Dive Logs',
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'date',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                value: 'depth',
                child: Text('Sort by Depth'),
              ),
              const PopupMenuItem(
                value: 'duration',
                child: Text('Sort by Duration'),
              ),
            ],
          ),
        ],
      ),
      body: OceanBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search dive sites, locations...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // Dive count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '${filteredDives.length} ${filteredDives.length == 1 ? 'dive' : 'dives'}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      'Sorted by: ${_sortBy == 'date' ? 'Date' : _sortBy == 'depth' ? 'Depth' : 'Duration'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Dive logs list
              Expanded(
                child: filteredDives.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isEmpty
                                  ? Icons.waves
                                  : Icons.search_off,
                              size: 64,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'No dive logs yet'
                                  : 'No dives found',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'Start logging your dives!'
                                  : 'Try a different search term',
                              style:
                                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.white70,
                                      ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          // Simulate refresh
                          await Future.delayed(const Duration(seconds: 1));
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredDives.length,
                          itemBuilder: (context, index) {
                            final dive = filteredDives[index];
                            return DiveCard(
                              dive: dive,
                              onTap: () => context.go('/dive-logs/${dive.id}'),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/dive-logs/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Dive'),
        backgroundColor: const Color(0xFF00A8E8),
      ),
    );
  }
}
