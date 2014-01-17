class Spree::Admin::UploadsController < Spree::Admin::ResourceController

	def index
	  render :template => "spree/admin/uploads/#{request.xhr? ? 'picker' : 'index'}", :layout => !request.xhr?
  end

  private

    def collection
      params[:q] ||= {}
      params[:q][:sort] ||= "created_at.desc"
      @search = Spree::Upload.search(params[:q])
      @collection = @search.result

      # Do not paginate when using AJAX request
      if request && !request.xhr?
        @collection = @collection.page(params[:page]).per(Spree::Config[:orders_per_page])
      end
      @collection
    end

end
