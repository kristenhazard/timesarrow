class ItemsController < ApplicationController
  
  before_filter :require_admin, :only => [ :index, :show, :new, :edit, :create ]
  before_filter :require_user, :only => [ :update ]
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @timelines = @item.timelines #show all timelines item belongs to
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    
    keywords = params[:keywords]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        category = @item.itemtype
        s = Search.new(keywords,category)
        res = s.get_item_search_response
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
      end
    end
  end


  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to(@item) 
    else
      render :action => "new" 
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { 
          flash[:notice] = 'Item was successfully updated.'
          redirect_to(@item)  
        }
        format.js   # renders update.js.rjs
      else
        format.html { render :action => "edit" }
        format.js   # renders update.js.rjs
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(items_url) 
  end
  
  def work_it
    @item = Item.find(params[:id])
    if logged_in?
      userid = current_user.id
      @review = @item.reviews.find_by_user_id(userid)
      if @review.nil?
        @item.reviews.build(:user_id => userid)
      end
    end
    render :partial => 'shared/item_work'
  end
  

end
