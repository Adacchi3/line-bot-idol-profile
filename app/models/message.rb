class Message < ApplicationRecord
  def create_reply(events)
    messages = []
    events.each { |event|
      case event
      when Line::Bot::Event::Message::Text
        message = {
          type: 'text',
          text: 'hoge'
        }
        messages << message
      end
    }
    messages
  end
end
