class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all.order(points: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
