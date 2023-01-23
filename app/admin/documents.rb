ActiveAdmin.register Document do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :content, :user_id, :department_id, :regulation_id, :subject_id, :college_id, :semester_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :user_id, :department_id, :regulation_id, :subject_id, :college_id, :semester_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
