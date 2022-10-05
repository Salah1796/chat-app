class Chat < ApplicationRecord
    belongs_to :application  , optional: true
    has_many :messages
    def as_json(*)
    super.except("id","application_id")
    end
    
    def self.create(application_token)
     chat_number = 0;
     application_id =  Application.get_application_id_by_token(application_token);
     if !application_id.nil? 
     chat = Chat.new()
     chat.application_id = application_id
     chat_number = get_last_chat_number(application_id)+1
     chat.Number = chat_number
     chat.save
     end
     return chat_number
     end 

    def self.get_last_chat_number(application_id)
      last_chat  = Chat.select("Number")
      .where(["application_id = :application_id", { application_id: application_id}])
      .order('Number DESC')
      .first
      return last_chat.nil? ? 0 : last_chat.Number 
     end

    def self.get_chat_by_application_token_and_chat_number(application_token,chat_number)
       chat  = Chat.joins('INNER JOIN applications ON chats.application_id = applications.id')
       .where(applications: {token: application_token})
       .find_by(["Number = :chat_number", {chat_number:chat_number}])
       return chat
     end
end
