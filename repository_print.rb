# frozen_string_literal: true

# /workspaces/Inventory-Management-System/display_repository_content.rb
require "clipboard"

def display_file_content(file_path, output_file)
  puts "#{file_path}"
  puts "```"
  content = File.read(file_path)
  puts "```\n"
  File.open(output_file, "a") { |f| f.puts("#{file_path}\n```#{content}```\n") }
end

# Specify the root directory of your repository
repository_root = "/workspaces/Inventory-Management-System/app/views"

# Specify the output file
output_file = "/workspaces/Inventory-Management-System/app/app_repository.txt"

allowed_file_types = [
  ".txt",
  ".md",
  ".rb",
  ".js",
  ".html",
  ".rake",
  ".log",
  ".json",
  ".lock",
  ".toml",
  ".ru",
  ".html.erb",
  ".erb",
]


excluded_items = [
  "/workspaces/Inventory-Management-System/app/assets/images",
  "/workspaces/Inventory-Management-System/app/assets/pagy",
  "/workspaces/Inventory-Management-System/app/channels",
  "/workspaces/Inventory-Management-System/app/mailers",
  "/workspaces/Inventory-Management-System/app/policies",
  "/workspaces/Inventory-Management-System/app/views/devise",
  "/workspaces/Inventory-Management-System/app/views/shared",
  "/workspaces/Inventory-Management-System/app/views/search",
]

additional_items = [] # Add or remove items as needed

# Combine files to display: files from the root directory, excluded items, and additional items
files_to_display = (Dir.glob(File.join(repository_root, "**", "*"), File::FNM_DOTMATCH)
  .select do |file|
  File.file?(file) &&
  allowed_file_types.include?(File.extname(file).downcase) &&
  excluded_items.none? { |excluded_item| file.include?(excluded_item) }
end) +
                   additional_items

# Display the content of each file and copy to clipboard
files_to_display.each do |file|
  display_file_content(file, output_file)
end

# Optionally copy the entire content to the clipboard
Clipboard.copy(File.read(output_file))
puts "All content copied to clipboard."
