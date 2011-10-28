module ApplicationHelper
  def is_current_user?
    @user == current_user
  end
end
