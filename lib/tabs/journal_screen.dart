import 'package:flutter/material.dart';
import 'package:muud_health/api/joural_api.dart';
import 'package:muud_health/auth/login_screen.dart';
import 'package:muud_health/model/jorunal_model.dart';
import 'package:muud_health/widgets/logout_dialog.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _entryController = TextEditingController();
  int _selectedMood = 0;
  List<JournalEntry> _entries = [];
  bool _isLoading = false;
  bool _isSubmitting = false;

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
      ).showSnackBar(SnackBar(content: Text('Error loading entries: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _submitEntry() async {
    final entryText = _entryController.text.trim();
    if (entryText.isEmpty || _selectedMood == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter text and select mood')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await JournalApi.submitEntry(
        entryText: entryText,
        moodRating: _selectedMood,
        timestamp: DateTime.now(),
      );

      setState(() {
        _entryController.clear();
        _selectedMood = 0;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Journal entry submitted!')));

      _loadEntries(); // refresh list
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Widget _buildMoodOption(int value, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = value),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              _selectedMood == value
                  ? const Color(0xFF7E22CE)
                  : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28,
          color: _selectedMood == value ? Colors.white : Colors.black45,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              showLogoutDialog(context);
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => const LoginScreen()),
              //   (Route<dynamic> route) => false,
              // );
            },
            child: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
        automaticallyImplyLeading: false,
        title: const Text('New Journal Entry'),
        backgroundColor: const Color(0xFFF2F2F7),
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodOption(1, Icons.sentiment_very_dissatisfied),
                _buildMoodOption(2, Icons.sentiment_dissatisfied),
                _buildMoodOption(3, Icons.sentiment_neutral),
                _buildMoodOption(4, Icons.sentiment_satisfied),
                _buildMoodOption(5, Icons.sentiment_very_satisfied),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Write your thoughts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _entryController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Start typing...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
            // const SizedBox(height: 16),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 70),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E22CE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    _isSubmitting
                        ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                        : const Text(
                          'Submit Entry',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
              ),
            ),
            const SizedBox(height: 20),
            // const Divider(),
          ],
        ),
      ),
    );
  }
}
