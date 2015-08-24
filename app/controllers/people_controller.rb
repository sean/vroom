class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = current_user.admin? ? Person.order(:name) : Person.owned_by(current_user).order(:name)
  end

  def new
    @person = Person.new
    @person.owner = current_user
  end

  def create
    @person = Person.new(person_params)
    @person.owner = current_user
    if @person.save
      flash[:notice] = "Person has been created."
      redirect_to @person
    else
      flash.now[:alert] = "Person has not been created."
      render "new"
    end
  end

  def show
    authorize @person, :show?
  end

  def edit
    authorize @person, :update?
  end

  def update
    authorize @person, :update?
    if @person.update(person_params)
      flash[:notice] = "Person has been updated."
      redirect_to @person
    else
      flash.now[:alert] = "Person has not been updated."
      render "edit"
    end
  end

  def destroy
    @person.destroy
    flash[:notice] = "Person has been deleted."
    redirect_to people_path
  end  

  private
  
  def set_person
    @person = Person.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The person you were looking for could not be found."
    redirect_to people_path
  end

  def person_params
    params.require(:person).permit(:name, :title)
  end
end