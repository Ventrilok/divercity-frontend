import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../widgets/ocean_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_fab.dart';
import '../providers/emergency_contacts_provider.dart';
import '../models/emergency_contact.dart';

/// Emergency contacts screen - displays and manages emergency contacts
class EmergencyContactsScreen extends ConsumerWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(emergencyContactsProvider);

    return Scaffold(
      appBar: const OceanAppBar(title: 'Emergency Contacts'),
      body: OceanBackground(
        child: SafeArea(
          child: contacts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.contact_emergency,
                        size: 64,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No emergency contacts',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add contacts to reach in case of emergency',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return _ContactCard(
                      contact: contact,
                      onEdit: () => _showEditDialog(context, ref, contact),
                      onDelete: () => _showDeleteDialog(context, ref, contact),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: AnimatedOceanFAB(
        onPressed: () => _showAddDialog(context, ref),
        icon: Icons.add,
        label: 'Add Contact',
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _ContactFormDialog(
        title: 'Add Emergency Contact',
        onSave: (name, relationship, phone, email) {
          final newContact = EmergencyContact(
            id: const Uuid().v4(),
            name: name,
            relationship: relationship,
            phone: phone,
            email: email.isEmpty ? null : email,
          );
          ref.read(emergencyContactsProvider.notifier).addContact(newContact);
        },
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    EmergencyContact contact,
  ) {
    showDialog(
      context: context,
      builder: (context) => _ContactFormDialog(
        title: 'Edit Emergency Contact',
        contact: contact,
        onSave: (name, relationship, phone, email) {
          final updatedContact = contact.copyWith(
            name: name,
            relationship: relationship,
            phone: phone,
            email: email.isEmpty ? null : email,
          );
          ref
              .read(emergencyContactsProvider.notifier)
              .updateContact(updatedContact);
        },
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    EmergencyContact contact,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text(
          'Are you sure you want to delete ${contact.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(emergencyContactsProvider.notifier)
                  .deleteContact(contact.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Contact card widget
class _ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ContactCard({
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF00A8E8),
                        Color(0xFF0077BE),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        contact.relationship,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFF0077BE)),
                  onPressed: onEdit,
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: 'Delete',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            // Phone
            Row(
              children: [
                const Icon(Icons.phone, size: 20, color: Color(0xFF0077BE)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    contact.phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${contact.phone}...'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Call'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF00A8E8),
                  ),
                ),
              ],
            ),

            // Email (if available)
            if (contact.email != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, size: 20, color: Color(0xFF0077BE)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      contact.email!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening email to ${contact.email}...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.mail_outline, size: 18),
                    label: const Text('Email'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF00A8E8),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Contact form dialog for adding/editing contacts
class _ContactFormDialog extends StatefulWidget {
  final String title;
  final EmergencyContact? contact;
  final Function(String name, String relationship, String phone, String email)
      onSave;

  const _ContactFormDialog({
    required this.title,
    this.contact,
    required this.onSave,
  });

  @override
  State<_ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<_ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _relationshipController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _relationshipController =
        TextEditingController(text: widget.contact?.relationship ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _emailController =
        TextEditingController(text: widget.contact?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _relationshipController,
                decoration: const InputDecoration(
                  labelText: 'Relationship *',
                  hintText: 'e.g., Parent, Spouse, Friend',
                  prefixIcon: Icon(Icons.favorite),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter relationship';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone *',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(
                _nameController.text.trim(),
                _relationshipController.text.trim(),
                _phoneController.text.trim(),
                _emailController.text.trim(),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.contact == null
                        ? 'Contact added successfully!'
                        : 'Contact updated successfully!',
                  ),
                ),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
