class IdeasController < ApplicationController

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = current_user.ideas.new(idea_params)
    if @idea.save
      flash[:notice] = "Idea successfully created"
      redirect_to user_path(@idea)
  else
      flash[:errors] = @idea.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @idea = current_user.ideas.find(params[:id])
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    if @idea.update(idea_params)
      redirect_to user_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    redirect_to user_path(@idea)
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
