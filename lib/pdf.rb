# This module contains the method to convert HTML to PDF

module PDF

  # This method will convert the HTML string passed from the controller to PDF
  def render_to_pdf(html_string)
    WickedPdf.new.pdf_from_string(html_string)
  end

end
