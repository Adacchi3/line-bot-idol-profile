class Message < ApplicationRecord
  def self.create_text(events)
    messages = []
    events.each { |event|
      case event
      when Line::Bot::Event::MessageType::Text
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
