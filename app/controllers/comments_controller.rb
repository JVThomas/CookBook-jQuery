class CommentsController < ApplicationController
  before_action :params_check, only:[:create]
  before_action :set_user, only:[:index, :show]
  before_action :set_comment, only:[:edit, :show, :update]
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.valid?
      @comment.save
      render json: @comment
    end
  end

  def index
    @comments = @user.comments
  end

  def edit
    authorize(@comment)
  end

  def update
    if params[:comment_content]
      @comment.update(content: params[:comment_content])
      render json: @comment
    else
      authorize(@comment)
      @comment.update(comment_params)
      if @comment.valid?
        flash[:notice] = "Comment successfully updated"
        redirect_to recipe_path(@comment.recipe)
      else
        render :edit
      end
    end
  end

  def show
    if !!@user && @user.id != @comment.user.id
      flash[:alert] = "Comment does not belong to specified user"
      home_redirect
    end
    render json: @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize(@comment)
    @comment.destroy
    render json: @comment
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :recipe_id)
    end

    def set_comment
      if Comment.exists?(params[:id])
        @comment = Comment.find(params[:id])
      else
        flash[:alert] = "Comment does not exist"
        home_redirect
      end
    end

end