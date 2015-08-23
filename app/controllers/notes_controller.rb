class NotesController < ApplicationController
  before_action :set_person
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def new
    @note = @person.notes.build
  end

  def create
    @note = @person.notes.build(note_params)
    if @note.save
      flash[:notice] = "Note has been created."
      redirect_to [@person, @note]
    else
      flash.now[:alert] = "Note has not been created."
      render "new"
    end 
  end

  def show
    authorize @person, :show?
  end

  def edit
  end

  def update
    if @note.update(note_params)
      flash[:notice] = "Note has been updated."
      redirect_to [@person, @note]
    else
      flash.now[:alert] = "Note has not been updated."
      render "edit"
    end
  end  

  def destroy
    @note.destroy
    flash[:notice] = "Note has been deleted."
    redirect_to @person
  end  

  private

  def note_params
    params.require(:note).permit(:details)
  end

  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_note
    @note = @person.notes.find(params[:id])
  end

end
