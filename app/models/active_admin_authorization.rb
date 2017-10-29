class ActiveAdminAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    user.role == 'admin'
  end
end
