class DocsController < ApplicationController
before_filter :signed_in_user, only: [:create, :destroy]
before_filter :correct_user, only: [ :edit, :update, :destroy]
before_action :set_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.all.order('doc_comments_count, created_at DESC').paginate(page: params[:page], per_page: 12)
    # @docs = Doc.by_votes.paginate(page: params[:page], per_page: 12)
    if params[:search]
      @docs = Doc.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 12)
    end
    respond_to do |format|
      format.html
      format.json { render json: @docs }
    end
  end

  def show
    @doc = Doc.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @doc }
      @timestamp = @doc.created_at.to_s.from(0).to(-5)
    end

  end

  def new
    @doc = Doc.new
  end

  def edit
  end

  def create
    @doc = Doc.new(doc_params)
    @doc.user = current_user
    @doc.save
    # secure_post = params.require(:doc).permit(:title, :user_id, :topic, 
    #   :license, :description, :filepicker_url)
    # @doc = current_user.docs.build(secure_post)

    respond_to do |format|
      if @doc.save
        format.html { redirect_to @doc, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @doc }
      else
        format.html { render :new }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update(doc_params)
        format.html { redirect_to @doc, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @doc }
      else
        format.html { render :edit }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def recent
    @docs = Doc.recent.order('created_at DESC').paginate(page: params[:page], per_page: 12)
    render action: :index
  end

  def active
    @docs = Doc.active.order('created_at DESC').paginate(page: params[:page], per_page: 12)
    render action: :index
  end

  def zeroviews
    @docs = Doc.zeroviews.order('created_at DESC').paginate(page: params[:page], per_page: 12)
    render action: :index
  end

  def vote
    vote = current_user.doc_votes.new(value: params[:value], doc_id: params[:id])
    if vote.save
      redirect_to :back, notice: "Thank you for voting."
    else
      redirect_to :back, alert: "Unable to vote, perhaps you already did."
    end
end
      
  private
    def set_doc
      @doc = Doc.find(params[:id])
      @doc.doc_comments.each {|c| puts c.doc.title}
    end

    def correct_user
      @doc = current_user.docs.find_by_id(params[:id])
      redirect_to root_url if @doc.nil?
    end
    
    def doc_params
      params.require(:doc).permit!
    end
end
