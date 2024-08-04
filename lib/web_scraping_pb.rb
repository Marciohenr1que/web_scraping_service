# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: web_scraping.proto

require 'google/protobuf'


descriptor_data = "\n\x12web_scraping.proto\x12\x0bwebscraping\"\x1c\n\rScrapeRequest\x12\x0b\n\x03url\x18\x01 \x01(\t\"2\n\x0eScrapeResponse\x12\x0f\n\x07success\x18\x01 \x01(\x08\x12\x0f\n\x07message\x18\x02 \x01(\t2]\n\x12WebScrapingService\x12G\n\nScrapeData\x12\x1a.webscraping.ScrapeRequest\x1a\x1b.webscraping.ScrapeResponse\"\x00\x62\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Webscraping
  ScrapeRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("webscraping.ScrapeRequest").msgclass
  ScrapeResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("webscraping.ScrapeResponse").msgclass
end
