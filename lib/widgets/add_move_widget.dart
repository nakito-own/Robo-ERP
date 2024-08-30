import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/app_widgets/custom_button.dart';

class AddMoveWidget extends StatefulWidget {
  final int robotId;
  final String currentStorage;
  final String robotName;

  AddMoveWidget({required this.robotId, required this.currentStorage, required this.robotName});

  @override
  _AddMoveWidgetState createState() => _AddMoveWidgetState();
}

class _AddMoveWidgetState extends State<AddMoveWidget> {
  late Future<List<String>> _storageOptions;
  String? _selectedStorage;

  @override
  void initState() {
    super.initState();
    _storageOptions = _fetchStorageOptions();
    _selectedStorage = widget.currentStorage;
  }

  Future<List<String>> _fetchStorageOptions() async {
    final url = Uri.parse('http://localhost:8000/api/addresses');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((item) => item['storage'] as String).toList();
    } else {
      throw Exception('Failed to load storage options');
    }
  }

  void _updateStorage() async {
    final url = Uri.parse('http://localhost:8000/api/robots/${widget.robotId}');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({'storage': _selectedStorage}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Movement added successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.of(context).pop();
    } else {
      print('Failed to update storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add move to ${widget.robotName}'),
      content: SizedBox(
        width: 800,
        height: 160,
        child: FutureBuilder<List<String>>(
          future: _storageOptions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No storage options available'));
            } else {
              final storageOptions = snapshot.data!;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10),
                  Image(image: AssetImage('assets/images/rover_image.png'), width: 140),
                  SizedBox(width: 20),
                  _buildStorageBox(widget.currentStorage),
                  SizedBox(width: 20),
                  Icon(Icons.arrow_forward),
                  SizedBox(width: 20),
                  _buildDropdown(storageOptions),
                ],
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        CustomButton(text: 'Add move', onPressed: _updateStorage),
      ],
    );
  }

  Widget _buildStorageBox(String storage) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        storage,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildDropdown(List<String> storageOptions) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: DropdownButton<String>(
        value: _selectedStorage,
        underline: SizedBox(),
        items: storageOptions.map((storage) {
          return DropdownMenuItem<String>(
            value: storage,
            child: Text(storage),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedStorage = value;
          });
        },
      ),
    );
  }
}
