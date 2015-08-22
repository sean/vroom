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

  private
   
  def person_params
    params.require(:person).permit(:name, :title)
  end
end