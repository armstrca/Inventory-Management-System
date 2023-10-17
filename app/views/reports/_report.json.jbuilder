json.extract! report, :id, :report_type, :date, :data_criteria, :created_at, :updated_at
json.url report_url(report, format: :json)
