class ItemStatusesController < ApplicationController
  def create_or_update
    @item_status = ItemStatus.find_or_create_by_user_id_and_item_id(:user_id => params[:user_id], 
                                                                    :item_id => params[:item_id])
    @item_status.status_id = params[:status_id]
    @item_status.save!
    render :nothing => true
  end
  def index
    @item_statuses = ItemStatus.all
  end
  
  def show
    @item_status = ItemStatus.find(params[:id])
  end
  
  def new
    @item_status = ItemStatus.new
  end
  
  def create
    @item_status = ItemStatus.new(params[:item_status])
    if @item_status.save
      flash[:notice] = "Successfully created item status."
      redirect_to @item_status
    else
      render :action => 'new'
    end
  end
  
  def edit
    @item_status = ItemStatus.find(params[:id])
  end
  
  def update
    @item_status = ItemStatus.find(params[:id])
    if @item_status.update_attributes(params[:item_status])
      flash[:notice] = "Successfully updated item status."
      redirect_to @item_status
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @item_status = ItemStatus.find(params[:id])
    @item_status.destroy
    flash[:notice] = "Successfully destroyed item status."
    redirect_to item_statuses_url
  end
end
