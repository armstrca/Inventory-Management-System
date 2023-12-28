# frozen_string_literal: true

# /workspaces/Inventory-Management-System/add_comment_to_files.rb
def add_comment_to_file(file_path)
  comment_char, comment_end = comment_chars_for_file(file_path)
  comment = "#{comment_char}#{file_path}#{comment_end}"
  content = File.read(file_path)
  content = "#{comment}\n#{content}"
  File.write(file_path, content)
end

def comment_chars_for_file(file_path)
  case File.extname(file_path)
  when ".rb"
    ["#", ""]
  when ".js"
    ["//", ""]
  when ".css"
    ["/* ", ""]
  when ".html"
    ["<!--", "-->"]
  when ".erb"
    ["<!--", "-->"]
  end
end

def process_files(directory, extensions)
  Dir.glob(File.join(directory, "**/*.{#{extensions.join(",")}}")).each do |file|
    add_comment_to_file(file)
  end
end
directory_to_search = "/workspaces/Inventory-Management-System/"
file_extensions = ["rb", "html", "html.erb", "css", "js"]
process_files(directory_to_search, file_extensions)
