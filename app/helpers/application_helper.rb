#/workspaces/Inventory-Management-System/app/helpers/application_helper.rb
module ApplicationHelper



  def generate_path(result)
    case result
    when Category
      category_path(result)
    when Report
      report_path(result)
    else
      "#"
    end
  end
end
