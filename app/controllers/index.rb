get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)  
  @user = User.find_by_username(@access_token.params[:screen_name])

  if @user == nil
    @user = User.create(username: @access_token.params[:screen_name],oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  end
  session[:user_id] = @user.id

  redirect '/'
end

post '/post_tweet' do
  session[:jid] = User.find(session[:user_id]).tweet(params[:tweet])
end


get '/status' do
  puts 'am i here?'
  if job_is_complete(session[:jid])
    @confirmation = "It worked!" 
  else
    @confirmation = "Still working on it..."
  end
end
