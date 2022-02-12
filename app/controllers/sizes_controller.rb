class SizesController < InheritedResources::Base

  private

    def size_params
      params.require(:size).permit(:name, :description)
    end

end
