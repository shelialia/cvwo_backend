# app/controllers/posts_controller.rb
class Api::V1::PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
  
    # GET /posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /posts/1
    def show
      render json: @post
    end
  
    # POST /posts
    def create
      @post = Post.new(post_params)
  
      if @post.save
        render json: { status: 'success', message: 'Post created successfully', post: @post }
      else
        render json: { status: 'error', message: 'Post creation failed', errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/1
    def destroy
      @post.destroy
      head :no_content
    end

  # GET /posts/search
    def search
        query = params[:query]
        @posts = Post.where("topic LIKE ?", "%#{query}%")
    
        render json: @posts
      end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
  end
  