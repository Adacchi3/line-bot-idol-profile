class Message < ApplicationRecord
  def self.send_message(client, events)
    events.each { |event|
      message = create_message(event)
      client.reply_message(event['replyToken'], message)
    }
  end

  private
  def self.create_message(event)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = Idol.profile(event.message['text'].gsub(/[^a-zA-Z0-9_]/, ''))
      else
        message = {
          type: 'text',
          text: 'メモ帳はその形式での検索に対応しておりません。'
        }
      end
    end
  end
end
