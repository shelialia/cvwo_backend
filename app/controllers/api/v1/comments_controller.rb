# app/controllers/comments_controller.rb
class Api::V1::CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]
  
    # GET /comments
    def index
      @post = Post.find(params[:post_id])
      render json: @post.comments
    end    
  
    # GET /comments/1
    def show
      render json: @comment
    end
  
    # POST /comments
    def create
      @comment = Comment.new(comment_params)
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /comments/1
    def update
      if @comment.update(comment_params)
        render json: @comment, status: :ok
      else
        render json: { status: 'error', message: 'Comment update failed', errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

  
    # DELETE /comments/1
    def destroy
      @comment.destroy
      head :no_content
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
  end
  