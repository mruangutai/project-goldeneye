class CodesController < ApplicationController
  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.search( params[:search], params[:page] )
    
    @pageTitle = "ICD-9-CM Diagnosis Codes Lookup Tool"
    @pageDesc = "Quick lookup tool for ICD-9 Codes &amp; Descriptions"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @codes }
    end
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
    @code = Code.find(params[:id])
    
    # Use slug-history to redirect old-slug to latest-slug.
    if request.path != code_path(@code)      
      redirect_to @code, status: :moved_permanently    
    else
      @pageTitle =  "ICD-9 Code for " + @code.long
      @pageDesc = "Quick lookup tool for ICD-9 Code for " + @code.long

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @code }
      end

    end

  end

  # # GET /codes/new
#   # GET /codes/new.json
#   def new
#     @code = Code.new
#   
#     respond_to do |format|
#       format.html # new.html.erb
#       format.json { render json: @code }
#     end
#   end
#   
#   # GET /codes/1/edit
#   def edit
#     @code = Code.find(params[:id])
#   end
#   
#   # POST /codes
#   # POST /codes.json
#   def create
#     @code = Code.new(params[:code])
#   
#     respond_to do |format|
#       if @code.save
#         format.html { redirect_to @code, notice: 'Code was successfully created.' }
#         format.json { render json: @code, status: :created, location: @code }
#       else
#         format.html { render action: "new" }
#         format.json { render json: @code.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#   
#   # PUT /codes/1
#   # PUT /codes/1.json
#   def update
#     @code = Code.find(params[:id])
#   
#     respond_to do |format|
#       if @code.update_attributes(params[:code])
#         format.html { redirect_to @code, notice: 'Code was successfully updated.' }
#         format.json { head :ok }
#       else
#         format.html { render action: "edit" }
#         format.json { render json: @code.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#   
#   # DELETE /codes/1
#   # DELETE /codes/1.json
#   def destroy
#     @code = Code.find(params[:id])
#     @code.destroy
#   
#     respond_to do |format|
#       format.html { redirect_to codes_url }
#       format.json { head :ok }
#     end
#   end
end
