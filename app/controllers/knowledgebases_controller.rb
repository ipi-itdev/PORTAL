class KnowledgebasesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_knowledgebases, only: [:show, :edit, :update, :destroy]
  #prepend_before_action :checker_oldpass, only: [:index,:show, :edit, :new] # Change this to be any actions you want to protect.
  #prepend_before_action :editmodchecker, only: [:edit,:destroy, :show, :new] # Change this to be any actions you want to protect.


  # GET /knowledgebases
  # GET /knowledgebases.json
  def index
    @knowledgebases = Knowledgebase.all
   

  end

  # GET /knowledgebases/1
  # GET /knowledgebases/1.json
  def show
  end

  # GET /knowledgebases/new
  def new
    @knowledgebases = Knowledgebase.new
  end

  # GET /knowledgebases/1/edit
  def edit
  end

  # POST /knowledgebases
  # POST /knowledgebases.json
  def create
    @knowledgebases = Knowledgebase.new(knowledgebases_params)

    respond_to do |format|
      if @knowledgebases.save
        format.html { redirect_to @knowledgebases, notice: 'Knowledgebase was successfully created.' }
        format.json { render :show, status: :created, location: @knowledgebases }
      else
        format.html { render :new }
        format.json { render json: @knowledgebases.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knowledgebases/1
  # PATCH/PUT /knowledgebases/1.json
  def update
    respond_to do |format|
      if @knowledgebases.update(knowledgebases_params)
        format.html { redirect_to @knowledgebases, notice: 'Knowledgebase was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledgebases }
      else
        format.html { render :edit }
        format.json { render json: @knowledgebases.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledgebases/1
  # DELETE /knowledgebases/1.json
  def destroy
    @knowledgebases.destroy
    respond_to do |format|
      format.html { redirect_to knowledgebases_url, notice: 'Knowledgebase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledgebases
      @knowledgebases = Knowledgebase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledgebases_params
      
      params.require(:knowledgebase).permit(:title, :article , :author)

    end

    private
    def checker_oldpass
      if current_user.blank?
        flash[:success] = "Welcome!"  
      else

        xcur = current_user.id
        ycur = User.where(id: xcur).pluck(:encrypted_password).to_sentence
        ycur1 = ycur.to_s
        zcur = "$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW"

      if ycur1.to_s ==  zcur.to_s
        redirect_to '/users/password/new' and return
      else
        flash[:success] = "Welcome!"  
      
      end
      end       
    end

    private
    def editmodchecker
      redirect_to '/knowledgebases/'  
    end

end
