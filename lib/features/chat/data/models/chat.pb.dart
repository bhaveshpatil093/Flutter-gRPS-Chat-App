///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.17

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:fixnum/fixnum.dart' as $fixnum;

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'Message',
    createEmptyInstance: create,
  )
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..e<MessageType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type',
        $pb.PbFieldType.OE,
        defaultOrMaker: MessageType.TEXT,
        valueOf: MessageType.valueOf,
        enumValues: MessageType.values)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRead')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mediaUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileName')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileSize')
    ..hasRequiredFields = false;

  Message._() : super();
  factory Message({
    $core.String? id,
    $core.String? senderId,
    $core.String? content,
    MessageType? type,
    $fixnum.Int64? timestamp,
    $core.bool? isRead,
    $core.String? mediaUrl,
    $core.String? fileName,
    $fixnum.Int64? fileSize,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (content != null) {
      _result.content = content;
    }
    if (type != null) {
      _result.type = type;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (isRead != null) {
      _result.isRead = isRead;
    }
    if (mediaUrl != null) {
      _result.mediaUrl = mediaUrl;
    }
    if (fileName != null) {
      _result.fileName = fileName;
    }
    if (fileSize != null) {
      _result.fileSize = fileSize;
    }
    return _result;
  }

  factory Message.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  Message clone() => Message()..mergeFromMessage(this);

  @$core.override
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);

  @$pb.TagNumber(4)
  MessageType get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(MessageType v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isRead => $_getBF(5);
  @$pb.TagNumber(6)
  set isRead($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasIsRead() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsRead() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get mediaUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set mediaUrl($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasMediaUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearMediaUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get fileName => $_getSZ(7);
  @$pb.TagNumber(8)
  set fileName($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasFileName() => $_has(7);
  @$pb.TagNumber(8)
  void clearFileName() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get fileSize => $_getI64(8);
  @$pb.TagNumber(9)
  set fileSize($fixnum.Int64 v) {
    $_setInt64(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasFileSize() => $_has(8);
  @$pb.TagNumber(9)
  void clearFileSize() => clearField(9);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'SendMessageRequest',
    createEmptyInstance: create,
  )
    ..aOM<Message>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message',
        subBuilder: Message.create)
    ..hasRequiredFields = false;

  SendMessageRequest._() : super();
  factory SendMessageRequest({
    Message? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }

  factory SendMessageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);

  @$core.override
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) =>
      super.copyWith((message) => updates(message as SendMessageRequest))
          as SendMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() =>
      $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);
}

class SendMessageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'SendMessageResponse',
    createEmptyInstance: create,
  )..hasRequiredFields = false;

  SendMessageResponse._() : super();
  factory SendMessageResponse() => create();
  factory SendMessageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SendMessageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  SendMessageResponse clone() => SendMessageResponse()..mergeFromMessage(this);

  @$core.override
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) =>
      super.copyWith((message) => updates(message as SendMessageResponse))
          as SendMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageResponse create() => SendMessageResponse._();
  SendMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageResponse> createRepeated() =>
      $pb.PbList<SendMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(create);
  static SendMessageResponse? _defaultInstance;
}

class GetMessagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'GetMessagesRequest',
    createEmptyInstance: create,
  )
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chatId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit',
        $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastMessageId')
    ..hasRequiredFields = false;

  GetMessagesRequest._() : super();
  factory GetMessagesRequest({
    $core.String? chatId,
    $core.int? limit,
    $core.String? lastMessageId,
  }) {
    final _result = create();
    if (chatId != null) {
      _result.chatId = chatId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (lastMessageId != null) {
      _result.lastMessageId = lastMessageId;
    }
    return _result;
  }

  factory GetMessagesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetMessagesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  GetMessagesRequest clone() => GetMessagesRequest()..mergeFromMessage(this);

  @$core.override
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetMessagesRequest))
          as GetMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest create() => GetMessagesRequest._();
  GetMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMessagesRequest> createRepeated() =>
      $pb.PbList<GetMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(create);
  static GetMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set chatId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastMessageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastMessageId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLastMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastMessageId() => clearField(3);
}

class GetMessagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'GetMessagesResponse',
    createEmptyInstance: create,
  )
    ..pc<Message>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messages',
        $pb.PbFieldType.PM, subBuilder: Message.create)
    ..hasRequiredFields = false;

  GetMessagesResponse._() : super();
  factory GetMessagesResponse({
    $core.Iterable<Message>? messages,
  }) {
    final _result = create();
    if (messages != null) {
      _result.messages.addAll(messages);
    }
    return _result;
  }

  factory GetMessagesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetMessagesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  GetMessagesResponse clone() => GetMessagesResponse()..mergeFromMessage(this);

  @$core.override
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetMessagesResponse))
          as GetMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse create() => GetMessagesResponse._();
  GetMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMessagesResponse> createRepeated() =>
      $pb.PbList<GetMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(create);
  static GetMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Message> get messages => $_getList(0);
}

class SubscribeToMessagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'SubscribeToMessagesRequest',
    createEmptyInstance: create,
  )
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chatId')
    ..hasRequiredFields = false;

  SubscribeToMessagesRequest._() : super();
  factory SubscribeToMessagesRequest({
    $core.String? chatId,
  }) {
    final _result = create();
    if (chatId != null) {
      _result.chatId = chatId;
    }
    return _result;
  }

  factory SubscribeToMessagesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeToMessagesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  SubscribeToMessagesRequest clone() =>
      SubscribeToMessagesRequest()..mergeFromMessage(this);

  @$core.override
  SubscribeToMessagesRequest copyWith(
          void Function(SubscribeToMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeToMessagesRequest))
          as SubscribeToMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeToMessagesRequest create() => SubscribeToMessagesRequest._();
  SubscribeToMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeToMessagesRequest> createRepeated() =>
      $pb.PbList<SubscribeToMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeToMessagesRequest>(create);
  static SubscribeToMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set chatId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => clearField(1);
}

class SubscribeToMessagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names')
        ? ''
        : 'SubscribeToMessagesResponse',
    createEmptyInstance: create,
  )
    ..aOM<Message>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message',
        subBuilder: Message.create)
    ..hasRequiredFields = false;

  SubscribeToMessagesResponse._() : super();
  factory SubscribeToMessagesResponse({
    Message? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }

  factory SubscribeToMessagesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeToMessagesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.override
  SubscribeToMessagesResponse clone() =>
      SubscribeToMessagesResponse()..mergeFromMessage(this);

  @$core.override
  SubscribeToMessagesResponse copyWith(
          void Function(SubscribeToMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as SubscribeToMessagesResponse))
          as SubscribeToMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeToMessagesResponse create() => SubscribeToMessagesResponse._();
  SubscribeToMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeToMessagesResponse> createRepeated() =>
      $pb.PbList<SubscribeToMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeToMessagesResponse>(create);
  static SubscribeToMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);
}

enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
  FILE,
  ;

  static const $core.List<MessageType> values = <MessageType>[
    TEXT,
    IMAGE,
    VIDEO,
    FILE,
  ];

  static MessageType valueOf($core.int value) {
    switch (value) {
      case 0:
        return TEXT;
      case 1:
        return IMAGE;
      case 2:
        return VIDEO;
      case 3:
        return FILE;
      default:
        throw $core.ArgumentError('Unknown MessageType value: $value');
    }
  }

  static final $core.Map<$core.int, MessageType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MessageType? valueOf($core.int value) => _byValue[value];

  const MessageType._($core.int v, $core.String n) : super(v, n);
} 