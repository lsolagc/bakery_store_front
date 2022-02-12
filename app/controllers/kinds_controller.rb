class KindsController < InheritedResources::Base

  private

    def kind_params
      params.require(:kind).permit(:name, :description)
    end

end
