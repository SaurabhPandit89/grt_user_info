platform = RUBY_PLATFORM

binary_path = ''
if platform.include?('darwin') # OS X machine
  binary_path = Rails.root.join('vendor/wicked_pdf/libexec', 'wkhtmltopdf-darwin-x86').to_s
elsif platform.include?('x86_64-linux') # 64-bit linux machine
  binary_path = Rails.root.join('vendor/wicked_pdf/libexec', 'wkhtmltopdf-linux-amd64').to_s
end

WickedPdf.config = {
    :exe_path => binary_path
}