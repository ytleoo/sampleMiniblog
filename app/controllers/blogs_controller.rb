class BlogsController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
    @blogs = Blog.all
  end

  def create
    Blog.create(title: blog_params[:title], text: blog_params[:text], user_id: current_user.id)
    redirect_to '/'
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params) if blog.user_id == current_user.id
    redirect_to '/'
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
    redirect_to '/'
  end

private
  def blog_params
    params.permit(:title, :text)
  end

  def move_to_index
    redirect_to '/' unless user_signed_in?
  end
  
end
