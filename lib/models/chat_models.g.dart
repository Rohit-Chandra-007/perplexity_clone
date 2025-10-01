// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    _SearchResult(
      title: json['title'] as String,
      url: json['url'] as String,
      snippet: json['snippet'] as String?,
    );

Map<String, dynamic> _$SearchResultToJson(_SearchResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'snippet': instance.snippet,
    };

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  query: json['query'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  sources:
      (json['sources'] as List<dynamic>?)
          ?.map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  answer: json['answer'] as String? ?? '',
  status:
      $enumDecodeNullable(_$ChatStatusEnumMap, json['status']) ??
      ChatStatus.loading,
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'query': instance.query,
      'timestamp': instance.timestamp.toIso8601String(),
      'sources': instance.sources,
      'answer': instance.answer,
      'status': _$ChatStatusEnumMap[instance.status]!,
    };

const _$ChatStatusEnumMap = {
  ChatStatus.loading: 'loading',
  ChatStatus.streaming: 'streaming',
  ChatStatus.completed: 'completed',
  ChatStatus.error: 'error',
};

_ChatState _$ChatStateFromJson(Map<String, dynamic> json) => _ChatState(
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isConnected: json['isConnected'] as bool? ?? false,
  error: json['error'] as String?,
);

Map<String, dynamic> _$ChatStateToJson(_ChatState instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'isConnected': instance.isConnected,
      'error': instance.error,
    };
