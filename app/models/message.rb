class Message < ApplicationRecord
  def self.send_message(client, events)
    events.each { |event|
      message = Object.new
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: Idol.profile
          }
        else
          message = {
            type: 'text',
            text: 'メモ帳はその形式での検索に対応しておりません。'
          }
        end
      end
      client.reply_message(event['replyToken'], message)
    }
  end
end
