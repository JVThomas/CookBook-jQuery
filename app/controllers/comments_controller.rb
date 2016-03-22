class CommentsController < ApplicationController
  before_action :params_check, only:[:create]
  before_action :set_user, only:[:index, :show]
  before_action :set_comment, only:[:edit, :show, :destroy, :update]
  
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
    authorize(@comment)
    comment_save(:edit)
  end

  def show
    if !!@user && @user.id != @comment.user.id
      flash[:alert] = "Comment does not belong to specified user"
      home_redirect
    end
  end

  def destroy
    @recipe = @comment.recipe
    authorize(@comment)
    @comment.destroy
    flash[:notice] = "Comment successfully deleted"
    redirect_to recipe_path(@recipe)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :recipe_id)
    end

    def comment_save(sym)
      @comment.update(comment_params) if sym == :edit
      if @comment.valid?
        @comment.save if sym == :new
        flash[:notice] = "Comment successfully saved"
        redirect_to recipe_path(@comment.recipe)
      else
        flash[:alert] = "Comment must be filled in" if sym == :new 
        redirect_to recipe_path(@comment.recipe) if sym == :new
        render :edit if sym == :edit
      end
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