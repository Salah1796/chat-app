class Message < ApplicationRecord
    belongs_to :chat ,   optional: true
    def as_json(*)
    super.except("id","chat_id")
     end
    include Searchable
    def self.get_chat_messages(application_token,chat_number)
      messages = Message.joins(chat: :application)
      .where(chats: {Number: chat_number})
      .where(applications: {token: application_token})
      return messages
    end  

    def self.create(body,application_token,chat_number)
      message_number = 0;
      chat  = Chat.get_chat_by_application_token_and_chat_number(application_token,chat_number)
       if(!chat.nil?) 
        message = Message.new()
        message.Body = body
        message.chat_id = chat.id
        last_message  = Message.select("Number")
       .where(["chat_id = :chat_id", { chat_id: chat.id}])
       .order('Number DESC')
       .first
       message_number =  last_message.nil? ? 1 : last_message.Number+1
       message.Number = message_number 
       message.save
       end
        return message_number
        end 

    def self.get_message_by_application_token_chat_number_message_number(application_token,chat_number,message_number)
       message = Message.joins(chat: :application)
      .where(chats: {Number: chat_number})
      .where(applications: {token: application_token})
      .find_by(["messages.Number = :message_number", {message_number:message_number}])
      return message
     end
end
