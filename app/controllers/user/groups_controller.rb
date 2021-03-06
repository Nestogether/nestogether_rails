class User::GroupsController < User::BaseController
  before_action :set_group, except:[:index, :new]
  respond_to :html
  def index
    @groups = current_user.groups
    @own_groups = Group.where(organizer: current_user)
  end

  def show
    @pending_list = @group.user_group_ships.where(state: "pending")
    @approved_list = @group.user_group_ships.where(state: "approved")
  end

  def new
    @group = current_user.groups.build
  end

  def create
    
  end

  def edit
  end

  def update
    @group.activate!
    respond_with(@group, location: user_group_path)
  end

  def destroy
  end

  def add_pin
    @rent_case = RentCase.find(params[:id])
    @pin = @rent_case.pins.build(group_params)
    if @pin.save
      redirect_to rent_case_path(@rent_case)
    else
      redirect_to rent_case_path(@rent_case), alert: "Fuck"
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params[:pin].permit(:group_id)
  end
end
