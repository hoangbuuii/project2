class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find_by id: params[:followed_id]
    check_valid @user
    current_user.follow @user
    response_to_user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    check_valid @user
    current_user.unfollow @user
    response_to_user
  end
end
