module Apis
  class LinebotController < ApplicationController
    protect_from_forgery :except => [:callback]

    def callback
      client    = Client.init
      body      = request.body.read
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(body, signature)
        head :bad_request
      end

      messages =  Message.create_text(client.parse_events_from(body))
      client.reply_message(event['replyToken'], messages)
      head :ok
    end
  end
end
