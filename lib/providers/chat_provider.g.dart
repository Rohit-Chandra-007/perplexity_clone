// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatNotifier)
const chatProvider = ChatNotifierProvider._();

final class ChatNotifierProvider
    extends $NotifierProvider<ChatNotifier, ChatState> {
  const ChatNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatNotifierHash();

  @$internal
  @override
  ChatNotifier create() => ChatNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatState>(value),
    );
  }
}

String _$chatNotifierHash() => r'03b6e1aadcc1a922ed47c7e92f0041d047ec28a8';

abstract class _$ChatNotifier extends $Notifier<ChatState> {
  ChatState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChatState, ChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatState, ChatState>,
              ChatState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentMessage)
const currentMessageProvider = CurrentMessageProvider._();

final class CurrentMessageProvider
    extends $FunctionalProvider<ChatMessage?, ChatMessage?, ChatMessage?>
    with $Provider<ChatMessage?> {
  const CurrentMessageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMessageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMessageHash();

  @$internal
  @override
  $ProviderElement<ChatMessage?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatMessage? create(Ref ref) {
    return currentMessage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatMessage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatMessage?>(value),
    );
  }
}

String _$currentMessageHash() => r'b8234afcc704ce525db1baddfe2950d17b065a31';

@ProviderFor(isLoading)
const isLoadingProvider = IsLoadingProvider._();

final class IsLoadingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoading(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingHash() => r'961cf744b03c44868fbe7ad11a834827aa9da3d3';

@ProviderFor(isStreaming)
const isStreamingProvider = IsStreamingProvider._();

final class IsStreamingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsStreamingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isStreamingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isStreamingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isStreaming(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isStreamingHash() => r'43624e80cca5665ea0111e46d0f137b606a8842b';
