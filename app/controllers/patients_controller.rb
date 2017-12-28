class PatientsController < ApplicationController

  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
    @prediction = nil
  end

  def create
    unknown = Patient.new(patient_params)
    k = params[:k].to_i
    @prediction = Patient.classify_unknown(unknown, k)

    @patient = Patient.new
    render :new
  end

  private

    def patient_params
      params.require(:patient).permit!
    end

end
