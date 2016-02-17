# show Create Post page
get '/posts/new' do
  @user = User.find(session[:user_id])
  if @user
    erb :"posts/new"
  else
    redirect '/users/login'
  end
end

#Create Post action
post '/users/:user_id/posts/new' do
  user = User.find(session[:user_id])
  @post = user.posts.new(post_content: params[:post_content])
  if @post.save
    redirect "/posts/#{@post.id}"
  else
    redirect '/posts/new'
    #error message?
  end
end

# show post
get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  erb :"posts/post_show"
end


# show update post page
get '/posts/:post_id/edit' do
  @post = current_user.posts.find(params[:post_id])
  erb :"posts/post_edit"
end

# update post
post '/posts/:post_id/update' do
  @post = current_user.posts.find(params[:post_id])
  @post.post_content = params[:post_content]
  @post.save
  redirect "posts/#{@post.id}"
end

# delete post
delete '/posts/:post_id/destroy' do
  user = User.find(session[:user_id])
  @post = user.posts.find(params[:post_id])
  @post.destroy
  redirect '/'
end
