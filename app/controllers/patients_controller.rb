class PatientsController < ApplicationController

  def index
    @patients = Patient.order(:distance_to_unknown)
  end

  def new
    @patient = Patient.new
    @prediction = nil
  end

  def create
    @patient = Patient.new(patient_params)
    if patient_params.include?("") || params[:k].strip == ""
      flash[:notice] = "Please enter all information."
      render :new
    else
      @prediction = Patient.classify_unknown(@patient, params[:k].to_i)
      render :new
    end
  end

  private

    def patient_params
      params.require(:patient).permit!
    end

end
