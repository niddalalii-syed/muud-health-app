
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muud_health/api/joural_api.dart';
import 'package:muud_health/auth/login_screen.dart';
import 'package:muud_health/model/jorunal_model.dart';
import 'package:muud_health/widgets/logout_dialog.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<JournalEntry> _entries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    setState(() => _isLoading = true);
    try {
      final entries = await JournalApi.fetchUserEntries();
      setState(() => _entries = entries);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load history: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  IconData getMoodIcon(int mood) {
    switch (mood) {
      case 1:
        return Icons.sentiment_very_dissatisfied;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
        return Icons.sentiment_satisfied;
      case 5:
      default:
        return Icons.sentiment_very_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              showLogoutDialog(context);
            
            },
            child: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Journal History'),
        backgroundColor: const Color(0xFFF2F2F7),
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _entries.isEmpty
              ? const Center(child: Text('No journal entries found.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  final date = DateFormat.yMMMd().add_jm().format(
                    entry.timestamp,
                  );
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              getMoodIcon(entry.moodRating),
                              color: const Color(0xFF7E22CE),
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Mood: ${entry.moodRating}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat.yMMMd().add_jm().format(
                                entry.timestamp,
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          entry.entryText,
                          style: const TextStyle(
                            fontSize: 15.5,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );

                  // return
                  //  Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   margin: const EdgeInsets.only(bottom: 16),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(getMoodIcon(entry.moodRating), color: Colors.orange),
                  //             const SizedBox(width: 8),
                  //             Text(
                  //               'Mood: ${entry.moodRating}',
                  //               style: const TextStyle(fontWeight: FontWeight.w600),
                  //             ),
                  //             const Spacer(),
                  //             Text(
                  //               date,
                  //               style: const TextStyle(color: Colors.black54, fontSize: 12),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(height: 12),
                  //         Text(
                  //           entry.entryText,
                  //           style: const TextStyle(fontSize: 15),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
    );
  }
}
