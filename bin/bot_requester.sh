#!/bin/sh
# 必要なパラメータ
# 環境変数に定義すること。
# BOT_URL : BotのURL
# LOG_FILE_PATH : ログ出力先フォルダ
# AUTH_USER : 認証ユーザ
# AUTH_PASS : 認証パスワード
echo $BOT_URL
echo $LOG_FILE_PATH
ruby ./bin/bot_requester.rb $BOT_URL $LOG_FILE_PATH $AUTH_USER $AUTH_PASS
