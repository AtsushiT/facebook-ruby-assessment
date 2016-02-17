get '/' do
  @posts = Post.all
  erb :"static/index"
end
