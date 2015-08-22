class PeopleController < ApplicationController

  def index
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
      # nothing, yet
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