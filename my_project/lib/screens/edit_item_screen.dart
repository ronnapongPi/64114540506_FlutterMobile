// lib/screens/edit_item_screen.dart
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../services/pocketbase_service.dart';

class EditItemScreen extends StatefulWidget {
  final RecordModel item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  PocketbaseService pbService = PocketbaseService();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item.data['title'] ?? '';
    _contentController.text = widget.item.data['content'] ?? '';
  }

  Future<void> _saveData() async {
    await pbService.updateData(widget.item.id, _titleController.text, _contentController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
