class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:notice] = "Person has been created."
      redirect_to @person
    else
      flash.now[:alert] = "Person has not been created."
      render "new"
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      flash[:notice] = "Person has been updated."
      redirect_to @person
    else
      flash.now[:alert] = "Person has not been updated."
      render "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:notice] = "Person has been deleted."
    redirect_to people_path
  end  

  private
   
  def person_params
    params.require(:person).permit(:name, :title)
  end
end