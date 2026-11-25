# frozen_string_literal: true

class VirtualMachineDuplicatesController < ApplicationController
  before_action :get_exercise
  before_action :get_source

  def show
    @duplicate = DuplicateVirtualMachineForm.new(virtual_machine_id: @source.id, name: "#{@source.name}-copy")
  end

  def create
    @duplicate = DuplicateVirtualMachineForm.new(params[:duplicate])
    @duplicate.virtual_machine_id = @source.id

    if @duplicate.save
      redirect_to [@exercise, @duplicate.duplicated],
                  notice: "#{@source.name} duplicated as #{@duplicate.duplicated.name}. Static IP addresses were left blank."
    else
      render :show, status: 400
    end
  end

  private
    def get_source
      @source = authorized_scope(@exercise.virtual_machines).find(params[:virtual_machine_id])
      authorize! @source, to: :duplicate?
    end
end
