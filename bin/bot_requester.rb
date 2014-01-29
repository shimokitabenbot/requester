# -*- coding: utf-8 -*-
require 'base64'
require 'logger'
require 'net/http'
# BotのURL
BOT_URL = ARGV[0]
LOG_FILE_PATH = ARGV[1]
LOG_FILE_NAME = "requester_#{Time.now.strftime('%Y-%m-%d')}.log"

logger = Logger.new("#{LOG_FILE_PATH}/#{LOG_FILE_NAME}")
logger.info("== Bot requester start ==")
logger.info("URL = #{BOT_URL}")
uri = URI.parse(BOT_URL)

# Basic 認証
AUTH_USER = ARGV[2]
AUTH_PASS = ARGV[3]
BASIC_AUTH =  Base64::encode64("#{AUTH_USER}:#{AUTH_PASS}")

# HTTPリクエスト
request = Net::HTTP::Post.new(uri.request_uri, initheader = {"Authorization" => "Basic #{BASIC_AUTH}"})
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

begin
  response = nil
  http.start do |h|
    response = h.request(request)
  end
  logger.info("response.code = #{response.code}")
  if response.code == "201"
    logger.info("Tweet Succeeded.")
    logger.info("Tweet content: #{response.body}")   
  else
    logger.info("Tweet Failed.")
    logger.info("Error: #{response.body}")
  end
rescue => e
  logger.error(e)
  logger.info("Bot HTTP Request Failed.")
end
logger.info("== Bot requester finished ==")

