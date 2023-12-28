# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/helpers/application_datatable.rb
class ApplicationDatatable
  delegate :params, to: :@view
  delegate :h, to: :@view
  delegate :link_to, to: :@view

  def initialize(view)
    @view = view
  end
end
