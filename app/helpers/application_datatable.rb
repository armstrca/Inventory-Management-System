class ApplicationDatatable
  delegate :params, to: :@view
  delegate :h, to: :@view
  delegate :link_to, to: :@view

  def initialize(view)
    @view = view
  end
end
