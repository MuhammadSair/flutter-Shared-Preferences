import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late List<String> noteValue;
  @override
  void initState() {
    super.initState();
    noteValue = [];
    getNotes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    noteValue = [];
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: noteValue.isEmpty
                ? const Text("No notes available")
                : Column(
                    children: [
                      for (var note in noteValue) Text(note),
                    ],
                  )),
      ),
    );
  }

  Future<void> getNotes() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      noteValue = preferences.getStringList("NotesData") ?? [];
    });
  }
}
