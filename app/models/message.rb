class Message < ApplicationRecord
  belongs_to :user
  belongs_to :game
  before_create :openai_request

  def openai_request
    client = OpenAI::Client.new(access_token: Rails.application.credentials.OPENAI_API_KEY)
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user",
         content: "make the following message like a caveman, send back just the modified message nothing else: #{self.body}"
         }], # Required.
        temperature: 0.7,
        })
    self.aimessage = response.dig("choices", 0, "message", "content")
    puts self.aimessage
  end
  after_create_commit { broadcast_append_later_to :messages, target: 'messages', partial: 'messages/message', locals: { message: self } }
end
