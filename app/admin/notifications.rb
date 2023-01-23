ActiveAdmin.register Notification do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :user_id, :college_id, :batch_id, :department_id, :regulation_id, :by_admin
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :user_id, :college_id, :batch_id, :department_id, :regulation_id, :by_admin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
