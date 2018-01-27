class CommentsController < ApplicationController

def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @comment = @restaurant.comments.build(comment_params)
  @comment.user = current_user
  @comment.save!
  redirect_to restaurant_path(@restaurant)
end

def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.find(params[:id])

    if current_user.admin?
      @comment.destroy
      if @comment.errors 
        flash[:alert] = @comment.errors.full_messages.to_sentence
      else
        flash[:notice] = "comment was sucessfully deleted"
      end

      redirect_to restaurant_path(@restaurant)
    end
  end

private

def comment_params
  params.require(:comment).permit(:content)
end

end
