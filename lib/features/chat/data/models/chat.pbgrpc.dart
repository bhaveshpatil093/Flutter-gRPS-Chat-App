///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;

export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$sendMessage = $grpc.ClientMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
      '/chat.ChatService/SendMessage',
      ($0.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendMessageResponse.fromBuffer(value));
  static final _$getMessages = $grpc.ClientMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
      '/chat.ChatService/GetMessages',
      ($0.GetMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMessagesResponse.fromBuffer(value));
  static final _$subscribeToMessages =
      $grpc.ClientMethod<$0.SubscribeToMessagesRequest, $0.SubscribeToMessagesResponse>(
          '/chat.ChatService/SubscribeToMessages',
          ($0.SubscribeToMessagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SubscribeToMessagesResponse.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendMessageResponse> sendMessage($0.SendMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMessagesResponse> getMessages($0.GetMessagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMessages, request, options: options);
  }

  $grpc.ResponseStream<$0.SubscribeToMessagesResponse> subscribeToMessages(
      $0.SubscribeToMessagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeToMessages, $async.Stream.fromIterable([request]),
        options: options);
  }
} 