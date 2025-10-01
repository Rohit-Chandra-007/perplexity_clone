import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:perplexity_clone/providers/history_provider.dart';
import 'package:perplexity_clone/models/chat_models.dart';
import './lib/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(const ProviderScope(child: TestFirebaseApp()));
}

class TestFirebaseApp extends StatelessWidget {
  const TestFirebaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TestFirebaseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestFirebaseScreen extends ConsumerStatefulWidget {
  const TestFirebaseScreen({super.key});

  @override
  ConsumerState<TestFirebaseScreen> createState() => _TestFirebaseScreenState();
}

class _TestFirebaseScreenState extends ConsumerState<TestFirebaseScreen> {
  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final testMessage = ChatMessage(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  query: 'Test query ${DateTime.now()}',
                  timestamp: DateTime.now(),
                  answer: 'Test answer for Firebase storage',
                  status: ChatStatus.completed,
                );

                await ref
                    .read(historyProvider.notifier)
                    .addMessage(testMessage);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Test message saved!')),
                );
              },
              child: const Text('Add Test Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(historyProvider.notifier).clearHistory();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('History cleared!')),
                );
              },
              child: const Text('Clear History'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: historyAsync.when(
                data: (history) {
                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final message = history[index];
                      return Card(
                        child: ListTile(
                          title: Text(message.query),
                          subtitle: Text(message.answer),
                          trailing: Text(message.timestamp.toString()),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      ElevatedButton(
                        onPressed: () => ref.refresh(historyProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
