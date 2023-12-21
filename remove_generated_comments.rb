# frozen_string_literal: true

# /workspaces/Inventory-Management-System/remove_generated_comments.rb

def remove_generated_comments(file_path)
  # Read the existing content of the file
  content = File.read(file_path)

  # Identify and remove lines matching the generated comments
  content = content.gsub(%r{^(\s*#|#\{|//|/\*|\<!--).*#{Regexp.escape(file_path)}.*?\n}m, "")

  # Write the modified content back to the file
  File.write(file_path, content)
end

def process_files(directory, extensions)
  Dir.glob(File.join(directory, "**/*.{#{extensions.join(",")}}")).each do |file|
    remove_generated_comments(file)
  end
end

# Specify the directory to start the search
directory_to_search = "/workspaces/Inventory-Management-System/"

# Specify the file extensions to target
file_extensions = ["rb", "html", "html.erb", "css", "js"]

# Process the files in the specified directory with the given extensions
process_files(directory_to_search, file_extensions)
