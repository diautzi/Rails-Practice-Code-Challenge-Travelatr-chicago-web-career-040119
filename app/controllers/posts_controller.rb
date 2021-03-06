class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @destination = @post.destination
    @blogger =  @post.blogger
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to post_path(@post)
    else
        @errors = @post.errors.full_messages
        render :new
    end
  end

  def update
    @post.update(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      @errors = @post.errors.full_messages
      render :edit
    end
  end

  def edit
  end

  def destroy
    @post.delete
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :likes, :blogger_id, :destination_id)
  end
end
