import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../widgets/ocean_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../providers/dive_log_provider.dart';
import '../models/dive_log.dart';

/// Add/Edit dive screen - form for creating or editing dive logs
class AddDiveScreen extends ConsumerStatefulWidget {
  final String? diveLogId;

  const AddDiveScreen({
    super.key,
    this.diveLogId,
  });

  @override
  ConsumerState<AddDiveScreen> createState() => _AddDiveScreenState();
}

class _AddDiveScreenState extends ConsumerState<AddDiveScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  late TextEditingController _diveSiteController;
  late TextEditingController _locationController;
  late TextEditingController _maxDepthController;
  late TextEditingController _durationController;
  late TextEditingController _waterTempController;
  late TextEditingController _notesController;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  bool get isEditMode => widget.diveLogId != null;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _diveSiteController = TextEditingController();
    _locationController = TextEditingController();
    _maxDepthController = TextEditingController();
    _durationController = TextEditingController();
    _waterTempController = TextEditingController();
    _notesController = TextEditingController();

    // If editing, load existing data
    if (isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadExistingDive();
      });
    }
  }

  void _loadExistingDive() {
    final allDives = ref.read(diveLogProvider);
    final dive = allDives.firstWhere((d) => d.id == widget.diveLogId);

    _diveSiteController.text = dive.diveSite;
    _locationController.text = dive.location;
    _maxDepthController.text = dive.maxDepth.toString();
    _durationController.text = dive.duration.toString();
    _waterTempController.text = dive.waterTemperature?.toString() ?? '';
    _notesController.text = dive.notes ?? '';
    _selectedDate = dive.diveDate;
    _selectedTime = TimeOfDay.fromDateTime(dive.diveDate);
  }

  @override
  void dispose() {
    _diveSiteController.dispose();
    _locationController.dispose();
    _maxDepthController.dispose();
    _durationController.dispose();
    _waterTempController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OceanAppBar(
        title: isEditMode ? 'Edit Dive' : 'Add Dive',
      ),
      body: OceanBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Dive Site
                _buildCard(
                  child: TextFormField(
                    controller: _diveSiteController,
                    decoration: const InputDecoration(
                      labelText: 'Dive Site *',
                      hintText: 'e.g., Blue Hole',
                      prefixIcon: Icon(Icons.water),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a dive site';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Location
                _buildCard(
                  child: TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location *',
                      hintText: 'e.g., Dahab, Egypt',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Date and Time
                _buildCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text('Date'),
                        subtitle: Text(
                          DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
                        ),
                        trailing: const Icon(Icons.edit),
                        onTap: _selectDate,
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.access_time),
                        title: const Text('Time'),
                        subtitle: Text(_selectedTime.format(context)),
                        trailing: const Icon(Icons.edit),
                        onTap: _selectTime,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Max Depth
                _buildCard(
                  child: TextFormField(
                    controller: _maxDepthController,
                    decoration: const InputDecoration(
                      labelText: 'Max Depth (meters) *',
                      hintText: 'e.g., 28.5',
                      prefixIcon: Icon(Icons.arrow_downward),
                      suffixText: 'm',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter max depth';
                      }
                      final depth = double.tryParse(value);
                      if (depth == null || depth <= 0) {
                        return 'Please enter a valid depth';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Duration
                _buildCard(
                  child: TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duration (minutes) *',
                      hintText: 'e.g., 45',
                      prefixIcon: Icon(Icons.timer),
                      suffixText: 'min',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter duration';
                      }
                      final duration = int.tryParse(value);
                      if (duration == null || duration <= 0) {
                        return 'Please enter a valid duration';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Water Temperature (optional)
                _buildCard(
                  child: TextFormField(
                    controller: _waterTempController,
                    decoration: const InputDecoration(
                      labelText: 'Water Temperature (°C)',
                      hintText: 'e.g., 24',
                      prefixIcon: Icon(Icons.thermostat),
                      suffixText: '°C',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      final temp = double.tryParse(value);
                      if (temp == null) {
                        return 'Please enter a valid temperature';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                _buildCard(
                  child: TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Add any additional notes...',
                      prefixIcon: Icon(Icons.note),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    maxLength: 500,
                  ),
                ),
                const SizedBox(height: 24),

                // Save Button
                OceanButton(
                  onPressed: _saveDive,
                  text: isEditMode ? 'Update Dive' : 'Save Dive',
                  icon: Icons.save,
                ),
                const SizedBox(height: 12),

                // Cancel Button
                OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveDive() {
    if (_formKey.currentState!.validate()) {
      // Combine date and time
      final diveDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Parse values
      final maxDepth = double.parse(_maxDepthController.text);
      final duration = int.parse(_durationController.text);
      final waterTemp = _waterTempController.text.isNotEmpty
          ? double.parse(_waterTempController.text)
          : null;

      if (isEditMode) {
        // Update existing dive
        final allDives = ref.read(diveLogProvider);
        final existingDive = allDives.firstWhere((d) => d.id == widget.diveLogId);

        final updatedDive = existingDive.copyWith(
          diveSite: _diveSiteController.text.trim(),
          location: _locationController.text.trim(),
          diveDate: diveDateTime,
          maxDepth: maxDepth,
          duration: duration,
          waterTemperature: waterTemp,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

        ref.read(diveLogProvider.notifier).updateDiveLog(updatedDive);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dive updated successfully!')),
        );
        context.go('/dive-logs/${widget.diveLogId}');
      } else {
        // Create new dive
        final newDive = DiveLog(
          id: const Uuid().v4(),
          diveSite: _diveSiteController.text.trim(),
          location: _locationController.text.trim(),
          diveDate: diveDateTime,
          maxDepth: maxDepth,
          duration: duration,
          waterTemperature: waterTemp,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

        ref.read(diveLogProvider.notifier).addDiveLog(newDive);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dive added successfully!')),
        );
        context.go('/dive-logs');
      }
    }
  }
}
