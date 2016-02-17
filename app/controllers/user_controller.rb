enable :sessions

#show signup page
get '/users/signup' do
  session[:user_id] ||= nil
  if session[:user_id]
    redirect 'users/logout'
  end

  erb :"/users/signup"
end

#signup action
post '/users/new' do
  if params[:password] != params[:confirm_password]
    redirect 'users/signup'
    #how to show error message here?
  end

  user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
  user.encrypt_password(params[:password])

  if user.save!
    session[:user_id] = user.id
    redirect 'users/mypage'
  else
    redirect 'users/signup'
    #how to show error message here?
  end
end

#show login page
get '/users/login' do
    if session[:user_id]
      redirect '/users/logout'
    else
      erb :"/users/login"
    end
end

#login action
post '/users/login' do
  if session[:user_id]
      redirect '/users/mypage'
  end

  user = User.authenticate(params[:email], params[:password])

  if user
    session[:user_id] = user.id
    redirect '/users/mypage'
  else
    redirect '/users/login'
  end
end


#show logout page
get '/users/logout' do
  unless session[:user_id]
    redirect 'users/login'
  end

  erb :"/users/logout"
end

#logout action
delete '/users/session' do
  session[:user_id] = nil
  redirect '/'
end

#show mypage
get '/users/mypage' do
  #サインインしていないときにこのURLきたらバグる
  @user = User.find(session[:user_id])
  if @user
    erb :"/users/mypage"
  else
    redirect '/users/login'
  end
end

