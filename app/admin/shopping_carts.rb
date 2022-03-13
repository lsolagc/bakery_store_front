ActiveAdmin.register ShoppingCart do
  menu priority: 5
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :status, :total_value
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :status, :total_value]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :user_id, :status, :total_value, :payment_status

  filter :user
  filter :products
  filter :status, as: :select
  filter :total_value
  filter :created_at
  filter :updated_at

end
