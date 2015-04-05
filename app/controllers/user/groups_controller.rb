class User::GroupsController < User::BaseController
  before_action :set_group, except:[:index]
  def index
    @groups = current_user.groups
    @own_groups = Group.where(organizer: current_user)
  end

  def show
    @pending_list = @group.user_group_ships.where(state: "pending")
    @approved_list = @group.user_group_ships.where(state: "approved")
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
