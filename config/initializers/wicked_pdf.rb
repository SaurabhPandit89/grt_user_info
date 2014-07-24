# Following code provides support for wkhtmltopdf gem.
# Executables used below are kept locally in the project's folder itself in vendor/wicked_pdf/libexec
# These executables are checked into Github repository.

# In order to support windows executable, please set the path for binary_path below.

platform = RUBY_PLATFORM

binary_path = ''
if platform.include?('darwin') # OS X machine
  binary_path = Rails.root.join('vendor/wicked_pdf/libexec', 'wkhtmltopdf-darwin-x86').to_s
elsif platform.include?('x86_64-linux') # 64-bit linux machine
  binary_path = Rails.root.join('vendor/wicked_pdf/libexec', 'wkhtmltopdf-linux-amd64').to_s
elsif platform.include?('win') # windows machine
  # binary_path setting goes here.
end

WickedPdf.config = {
    :exe_path => binary_path
}