class InvoicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :generate_invoice

  def generate_invoice
    respond_to do |format|
      format.pdf do
        pdf = InvoicePdf.new(invoice_params)
        send_data pdf.render, filename: 'invoice.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  private
  def invoice_params
    params.require(:invoice).permit(:business_name, :city, :client_name)
  end
end
