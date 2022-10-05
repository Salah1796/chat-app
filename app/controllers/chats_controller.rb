class ChatsController < ApplicationController
   before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats/:application_token/:chat_number
  def show
    if  @chat.nil?
        render  json: "application or chat Not found", status: :unprocessable_entity
        else
        render json:  @chat, status: :ok
    end
  end
  # POST /chats/:application_token
  def create
      chat_number =  Chat.create(params[:application_token])
      if chat_number >0
         render json: chat_number, status: :created
         else
         render  json: "application Not found", status: :unprocessable_entity
      end
  end
  # GET chats/:application_token/:chat_number/messages
  def messages
    messages = Message.get_chat_messages(params[:application_token],params[:chat_number])
    if  messages.nil?
        render  json: "application_token or chat Not found", status: :unprocessable_entity
        else
         render json: messages, status: :ok
    end
  end
  # # PUT /chats/:application_token/:chat_number
  # def update
  #   if  @chat.nil?
  #     render  json: "application or chat Not found", status: :unprocessable_entity
  #   elsif  @chat.update()
  #         render json: @chat
  #   else
  #         render json: @chat.errors, status: :unprocessable_entity
  #   end
  # end
  # # DELETE /chats/1
  # def destroy
  #   @chat.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.get_chat_by_application_token_and_chat_number(params[:application_token],params[:chat_number])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:Number)
    end
end
