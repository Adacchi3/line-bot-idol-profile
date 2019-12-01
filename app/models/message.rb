class Message < ApplicationRecord
  def self.send_message(client, events)
    events.each { |event|
      case event
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: 'hoge'
        }
        client.reply_message(event['replyToken'], messages)
      end
    }
  end
end
