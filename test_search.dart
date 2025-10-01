import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perplexity_clone/providers/chat_provider.dart';

void main() {
  runApp(const ProviderScope(child: TestApp()));
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TestSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestSearchScreen extends ConsumerStatefulWidget {
  const TestSearchScreen({super.key});

  @override
  ConsumerState<TestSearchScreen> createState() => _TestSearchScreenState();
}

class _TestSearchScreenState extends ConsumerState<TestSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your query...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                final query = _controller.text.trim();
                if (query.isNotEmpty) {
                  print('Sending query: $query');
                  try {
                    await ref.read(chatProvider.notifier).sendQuery(query);
                    print('Query sent successfully');
                  } catch (e) {
                    print('Error sending query: $e');
                  }
                }
              },
              child: isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Send Query'),
            ),
            const SizedBox(height: 16),
            Text('Connected: ${chatState.isConnected}'),
            Text('Messages: ${chatState.messages.length}'),
            Text('Error: ${chatState.error ?? 'None'}'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: chatState.messages.length,
                itemBuilder: (context, index) {
                  final message = chatState.messages[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Query: ${message.query}'),
                          Text('Status: ${message.status}'),
                          Text('Sources: ${message.sources.length}'),
                          Text('Answer: ${message.answer.substring(0, message.answer.length > 100 ? 100 : message.answer.length)}...'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}