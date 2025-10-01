import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';

class DebugPanel extends ConsumerWidget {
  const DebugPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final isStreaming = ref.watch(isStreamingProvider);
    final currentMessage = ref.watch(currentMessageProvider);
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Debug Info',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          _buildDebugRow('Connected', chatState.isConnected.toString()),
          _buildDebugRow('Messages', chatState.messages.length.toString()),
          _buildDebugRow('Is Loading', isLoading.toString()),
          _buildDebugRow('Is Streaming', isStreaming.toString()),
          _buildDebugRow('Current Status', currentMessage?.status.toString() ?? 'None'),
          _buildDebugRow('Error', chatState.error ?? 'None'),
          if (currentMessage != null) ...[
            const SizedBox(height: 4),
            _buildDebugRow('Query', currentMessage.query),
            _buildDebugRow('Sources', currentMessage.sources.length.toString()),
            _buildDebugRow('Answer Length', currentMessage.answer.length.toString()),
          ],
        ],
      ),
    );
  }
  
  Widget _buildDebugRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}