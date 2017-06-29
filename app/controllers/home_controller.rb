class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :comment_create, :comment_destroy]
  def index
    @posts = Post.page params[:page]
  end

  def create

  end

  def real_create
    @user = User.find(current_user.id)
    @imgUploader = ImgUploader.new
    @imgUploader.store!(params[:img])
    @post = @user.posts.new(title: params[:title], content: params[:content], img_url: @imgUploader.url)

    @post.save

    redirect_to '/'
  end

  def destroy
    post = Post.find(params[:id])
    #pos.comments.destroy 어쩌고~ 의존성 주입 없을때
    post.destroy

    redirect_to '/'
  end

  def read
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  end

  def real_update
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.content = params[:content]

    #img 수정하기는 if 문 써서 img가 새로 들어 왔는지 확인하는 등 여러가지가 필요할 것 같다 + javascript

    @post.save

    redirect_to '/'
  end

  def comment_create
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id:params[:post_id], comment:params[:comment])
    @comment.save

    redirect_to :back

    #redirect_to 'home/read/'+@comment.post_id.to_s+'#comment'
    #url에 post_id넘겨서 실행하는것은 좋은 방식이 아닌듯 input hidden 등을 사용
  end

  def comment_destroy
    Comment.destroy(params[:id])

    redirect_to :back
  end
end
