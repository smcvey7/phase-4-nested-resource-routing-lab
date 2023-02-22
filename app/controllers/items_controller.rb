class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def show
    item = Item.find_by!(id: params[:id])
    render json: item
  end

  def index
    if params[:user_id]
      user = User.find_by!(id: params[:user_id])
      render json: user.items, include: :user
    else
      items = Item.all
      render json: items, include: :user
    end

    def create
      item = Item.create(item_params)
      render json: item, status: :created
    end

  end
  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end 

  def render_record_not_found
    # byebug
    render json: {error: "User not found"}, status: :not_found
  end
end
