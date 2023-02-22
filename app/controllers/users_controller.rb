class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  
  def show
    user = User.find_by!(id: params[:id])
    render json: user, include: :items
  end

  private
  def render_record_not_found
    # byebug
    render json: {error: "User not found"}, status: :not_found
  end
end
