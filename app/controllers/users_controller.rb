class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]


  # GET /users/new
  def new
    @user = User.new
    @game = Game.find(params[:game_id])
  end



  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @game = Game.find(params[:user][:game_id])
    respond_to do |format|
      if @user.save
        cookies[:user_name] = @user.name
        cookies[:user_id] = @user.id
        format.html { redirect_to game_url(@game), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :game_id)
    end
end
