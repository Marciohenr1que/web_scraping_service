require 'grpc'
require_relative 'lib/notification_service_pb'

begin
  notification_stub = Notification::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
  request = Notification::WebscrapingNotificationRequest.new(message: 'Test message')
  response = notification_stub.send_webscraping_notification(request)
  puts "Notification response: #{response.inspect}"
rescue => e
  puts "Error: #{e.message}"
end