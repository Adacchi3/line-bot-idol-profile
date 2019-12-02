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
        {
          type: 'text',
          text: Idol.profile
        }
      else
        {
          type: 'text',
          text: 'メモ帳はその形式での検索に対応しておりません。'
        }
      end
    else
      {
        type: 'text',
        text: event.to_s
      }
    end
  end
end
