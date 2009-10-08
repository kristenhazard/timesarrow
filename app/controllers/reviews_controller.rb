class ReviewsController < ApplicationController
  
  before_filter :authorize
  
  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @review = Review.new
  end
  
  def create
    if logged_in?
      userid = current_user.id
    end
    @review = Review.new(params[:review])
    @review.user_id = user_id
    if @review.save
      flash[:notice] = "Successfully created review."
      redirect_to @review
    else
      render :action => 'new'
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = "Successfully updated review."
      redirect_to @review
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Successfully destroyed review."
    redirect_to reviews_url
  end
end
