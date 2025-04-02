import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback onSetupComplete;
  const SetupScreen({super.key, required this.onSetupComplete});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  Future<void> _checkUrlAndProceed() async {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text.trim();
      final token = _tokenController.text.trim();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Checking URL...")));
      try {
        final response = await http.get(
          Uri.parse("$url/api/info"),
          headers: {"accept": "application/ld+json", "authorization": "Bearer $token"},
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body) as Map<String, dynamic>;
          if (responseData["@type"] != "PartDBInfo") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Provided URL is not a PartDB Instance.")),
            );
            return;
          }
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("partdb_url", url);
          await prefs.setString("partdb_token", token);
          widget.onSetupComplete();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to connect. Status: ${response.statusCode}",
              ),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Let's set PartDB up!"),
            TextFormField(
              controller: _urlController,
              validator: (value) {
                if (value == null) return "URL can't be null";
                if (value.isEmpty) return "URL can't be empty";
                if (!value.contains("http"))
                  return "URLs start with at least HTTP";
                return null;
              },
              decoration: const InputDecoration(hintText: "Enter URL"),
            ),
            TextFormField(
              controller: _tokenController,
              validator: (value) {
                if (value == null) return "Token can't be null";
                if (value.isEmpty) return "Token can't be empty";
                if (!value.startsWith("tcp_"))
                  return "Token must start with _tcp";
                if (value.length != 68)
                  return "Token must be 68 characters long.";
                return null;
              },
              decoration: const InputDecoration(hintText: "Enter Token"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: ElevatedButton(
                onPressed: _checkUrlAndProceed,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
