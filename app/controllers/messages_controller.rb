class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages/:application_token/:chat_number/:message_number
  def show
    if  @message.nil?
        render  json: "application or  chat Not found", status: :unprocessable_entity
        else
        render json: @message, status: :ok
    end
  end

  # POST /messages/:application_token/:chat_number
  def create
      message_number =  Message.create(message_params[:Body],params[:application_token],params[:chat_number])
      if message_number >0
         render json: message_number, status: :created
         else
             render  json: "application or chat Not found", status: 404
      end
  end

 

   # GET /messages/:application_token/:chat_number/search/:query
   def search
    query = params["query"] || ""
    res = Message.search(query)
    render json: res.response["hits"]["hits"]
  end

#  # PATCH/PUT /messages/1
#  def update
#   if @message.update(message_params)
#      render json: @message
#      else
#         render json: @message.errors, status: :unprocessable_entity
#   end
# end

# # DELETE /messages/:application_token/:chat_number/:message_number
# def destroy
#   @message.destroy
# end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.get_message_by_application_token_chat_number_message_number(params[:application_token],params[:chat_number],params[:message_number])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:Body)
    end
end
