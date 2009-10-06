class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end
  
  def show
    @status = Status.find(params[:id])
  end
  
  def new
    @status = Status.new
  end
  
  def create
    @status = Status.new(params[:status])
    if @status.save
      flash[:notice] = "Successfully created status."
      redirect_to @status
    else
      render :action => 'new'
    end
  end
  
  def edit
    @status = Status.find(params[:id])
  end
  
  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      flash[:notice] = "Successfully updated status."
      redirect_to @status
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    flash[:notice] = "Successfully destroyed status."
    redirect_to statuses_url
  end
end
