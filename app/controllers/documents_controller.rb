class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /documents
  # GET /documents.json
  def index
    #@documents = Document.all
    @documents = current_user.documents
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @documents = current_user.documents.find(params[:id])
  end

  #this action will let the users download the files (after a simple authorization check) 
  def get 
    document = current_user.documents.find_by_id(params[:id]) 

    if document 
     send_file document.uploaded_file.path, :type => document.uploaded_file_content_type 
   else
    flash[:error] = "You're trying to acces other people's files"
    redirect_to documents_path 
  end
end

  # GET /documents/new
  def new
    #@document = Document.new
    @document = current_user.documents.new
  end

  # GET /documents/1/edit
  def edit
    @document = current_user.documents.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    #@document = Document.new(document_params)
    @document = current_user.documents.create(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    @document = current_user.documents.find(params[:id])
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    #@document = current_user.documents.find(params[:id])
    @document.destroy
    
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:user_id)
      params.require(:document).permit(:uploaded_file)
    end
  end
