class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]  	
  before_filter :correct_user,   only: :destroy
    def index
      @microposts = Micropost.all
    # @microposts = @microposts.paginate(:page => params[:page], :per_page => 1)
    end

    def show
      @micropost = Micropost.find(params[:id])
    end
    
    def new
      @micropost = Micropost.new
    end
    
    def edit
      @micropost = Micropost.find(params[:id])

    end

    def update
      @micropost = Micropost.find(params[:id])
      if @micropost.update_attributes(micropost_params)
      # Handle a successful update.
      flash[:success] = "Micropost updated"
      redirect_to current_user
      else
      render 'edit'
      end
    end

    def create
      secure_post = params.require(:micropost).permit(:content)
      @micropost = current_user.microposts.build(secure_post) 
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end

    def destroy
      @micropost.destroy
      redirect_to :back
    end

    private
      def correct_user
        @micropost = current_user.microposts.find_by_id(params[:id])
        redirect_to root_url if @micropost.nil?
        flash[:notice] = "You are not the creator of this micropost, therefore you're not permitted to edit or destroy this post."
      end
      def micropost_params
        params.require(:micropost).permit!
      end
    end