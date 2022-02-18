ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :name, :description, :photo, combinations_attributes: [:id, :product_id, :kind_id, :size_id, :price, :_destroy]

  show do
    panel "Product Details" do
      attributes_table_for product do
        row :name
        row :description

        panel "Combinations" do
          table_for product.combinations do
            column "Kind",  :kind
            column "Size",  :size
            column "Price", :price
          end
        end

        panel "Photo" do
          render 'photo', product: product
        end

      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.inputs do
        f.has_many :combinations, heading: 'Combinations',
                                allow_destroy: true,
                                new_record: true do |c|
          c.input :size
          c.input :kind
          c.input :price
        end
      end
      f.inputs "Photo" do
        f.input :photo, as: :file
      end
    end

    f.actions
  end

end
