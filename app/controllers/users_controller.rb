class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    if !signed_in?
      @user = User.new
      @title = "Sign up"
    else
      flash[:notice] = "Already signed in!"
      #redirect_to users_path
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def create
    redirect_to root_path if signed_in?
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password=""
      @user.password_confirmation=""
      render 'new'
    end
  end

  def destroy
    destroy_user=User.find(params[:id])
    if destroy_user==current_user
      flash[:notice] = "Don't destroy yourself!"
      redirect_to users_path
    else
      destroy_user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
