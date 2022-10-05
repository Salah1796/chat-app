class Application < ApplicationRecord
    has_many :chats
    def as_json(*)
    super.except("id")
    end

    def self.get_application_id_by_token(token)
       application =  Application.select("id")
        .where(["token = :application_token", { application_token: token}])
        .first
        return application.nil? ? nil : application.id 
    end

    def self.get_application_chats(token)
         application =  Application.eager_load('chats').select("id").where(["token = :application_token", { application_token: token}]).first 
         return application.nil? ? nil : application.chats 
     end
    
end
