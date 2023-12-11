#/workspaces/Inventory-Management-System/app/helpers/application_helper.rb
# app/helpers/application_helper.rb
module ApplicationHelper



  def generate_path(result)
    case result
    when Category
      category_path(result)
    # Add similar cases for other models
    when Report
      report_path(result)
    # Add more cases as needed
    else
      "#"
    end
  end
end
