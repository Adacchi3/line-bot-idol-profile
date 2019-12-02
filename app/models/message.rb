class Message < ApplicationRecord
  def self.send_message(client, events)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: "flex",
            altText: "アイドルのプロフィールを閲覧しました。",
            contents: Idol.profile
          }
          client.reply_message(event['replyToken'], message)
        else
          message = {
            type: 'text',
            text: 'メモ帳はその形式での検索に対応しておりません。'
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }
  end

  private
  def self.create_message(event)
  
  end
end
