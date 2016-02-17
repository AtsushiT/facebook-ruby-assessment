# create comment
post '/posts/:post_id/comments/new' do
  user = User.find(session[:user_id])
  post = Post.find(params[:post_id])
  @comment = post.comments.new(comment_content: params[:comment_content], user_id: user.id)
  if @comment.save
    redirect "/posts/#{post.id}"
  else
    redirect "/posts/#{post.id}"
    #error message?
  end
end

# show update comment page
get '/comments/:comment_id/edit' do
  @comment = current_user.comments.find(params[:comment_id])
  erb :"comments/comment_edit"
end

# update comment
post '/comments/:comment_id/update' do
  @comment = current_user.comments.find(params[:comment_id])
  @comment.comment_content = params[:comment_content]
  @comment.save
  redirect "posts/#{@comment.post.id}"
end


# delete comment
delete '/comments/:comment_id/destroy' do
  user = User.find(session[:user_id])
  @comment = user.comments.find(params[:comment_id])
  @comment.destroy
  redirect "posts/#{@comment.post.id}"
end
