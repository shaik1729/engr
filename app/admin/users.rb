ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :password_confirmation, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :college_id, :role_id, :name, :reg_no, :mobile_number, :batch_id, :department_id, :regulation_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end  

  form do |f|
    f.inputs do
      f.input :college
      f.input :role
      f.input :email
      f.input :mobile_number
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
