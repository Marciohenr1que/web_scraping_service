# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: notification.proto

require 'google/protobuf'


descriptor_data = "\n\x12notification.proto\x12\x0cnotification\"1\n\x1eWebscrapingNotificationRequest\x12\x0f\n\x07message\x18\x01 \x01(\t\"8\n\x14NotificationResponse\x12\x0f\n\x07success\x18\x01 \x01(\x08\x12\x0f\n\x07message\x18\x02 \x01(\t2\x86\x01\n\x13NotificationService\x12o\n\x1bSendWebscrapingNotification\x12,.notification.WebscrapingNotificationRequest\x1a\".notification.NotificationResponseb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module NotificationPb
  WebscrapingNotificationRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("notification.WebscrapingNotificationRequest").msgclass
  NotificationResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("notification.NotificationResponse").msgclass
end
