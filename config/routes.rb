Rails.application.routes.draw do
  resources :applications 

  #applications
  get '/applications/:application_token/chats', to: 'applications#chats' 

  #chats -- Done 
  get '/chats/:application_token/:chat_number', to: 'chats#show'
  # put	 '/chats/:application_token/:chat_number', to: 'chats#update'
  post '/chats/:application_token', to: 'chats#create' #Pending..
  get '/chats/:application_token/:chat_number/messages', to: 'chats#messages'
  # delete '/chats/:application_token/:chat_number', to: 'chats#destroy'



 #messages  -- Done 
get '/messages/:application_token/:chat_number/:message_number', to: 'messages#show'
# put	 '/chats/:application_token/:chat_number/:message_number', to: 'messages#update'
post '/messages/:application_token/:chat_number', to: 'messages#create' #Pending..
# delete '/messages/:application_token/:chat_number/:message_number', to: 'messages#destroy'
get '/messages/:application_token/:chat_number/search/:query', to: 'messages#search' #Pending..


end
