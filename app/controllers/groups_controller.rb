class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :join_group]
  respond_to :html

  def index
    @groups = Group.all.includes(:rent_case)
  end

  def show
    @user_group_ship = @group.user_group_ships.build if @group.can_join?(current_user)
  end

  def new
    @rent_case = LandlordRentCase.find(params[:rent_case_id])
    @group = @rent_case.groups.build
  end

  def create
    @rent_case = LandlordRentCase.find(params[:rent_case_id])
    @group = @rent_case.groups.build
    @group.save
    respond_with(@group)
  end

  def edit
  end

  def destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params[:group].permit!
  end
end
