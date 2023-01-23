ActiveAdmin.register Result do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :subject_id, :regulation_id, :batch_id, :semester_id, :user_id, :college_id, :department_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :subject_id, :regulation_id, :batch_id, :semester_id, :user_id, :college_id, :department_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
