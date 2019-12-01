module Apis
  class LinebotController < ApplicationController
    protect_from_forgery :except => [:callback]

    def callback
      client    = Clients.init
      body      = request.body.read
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(body, signature)
        head :bad_request
      end

      messages =  Messages.create_messages(client.parse_events_form(body))
      client.reply_message(event['replyToken'], messages)
      head :ok
    end
  end
end
