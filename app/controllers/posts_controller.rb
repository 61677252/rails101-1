class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
end

def create
  @group = Group.find(params[:group_id])
  @post =Post.new(post_params)
  @post.group = @group
  @post.user = current_user

  if @post.save
    redirect_to group_path(@group)
  else
    render :new
  end
end

def updated
    @group = Group.find(params[:group_id])
    @post.Post.update(post_params)
    redirect_to posts_path, notice: "Update Success"
  else
    render :edit
end
end


def edit
  @group = Group.find(params[:id])
end

def destroy
  @group = Group.find(params[:id])
  @post =Post.destroy(post_params)
  flash[:alert] = "deleted"
  redirect_to posts_path(@post)
end


private
def find_group_and_check_permission
  @group = Group.find(params[:id])
  if current_user != @post.user
    redirect_to root_path, alert: "You have no permission"
  end

def post_params
  params.require(:post).permit(:title, :description)
end
end
