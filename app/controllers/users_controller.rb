class UsersController < ApplicationController
  before_filter :require_admin, :except => [:new, :show, :edit, :create]

  def index
    @users = User.all
    self.title = "TIME'S ARROW - Users"
  end

  def show
    @user = User.find(params[:id])
    self.title = "TIME'S ARROW - Show User"
  end

  def new
    @user = User.new
    self.title = "TIME'S ARROW - Sign Up"
  end

  def edit
    @user = current_user
    self.title = "TIME'S ARROW - Edit User"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_back_or_default root_url
    else
      render :action => "new" 
    end
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user) 
    else
      render :action => "edit" 
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end
end
