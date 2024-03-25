require "prawn"

class InvoicePdf < Prawn::Document
  def initialize(invoice_params)
    super()

    # Params
    business_name = invoice_params[:business_name]
    city = invoice_params[:city]
    client_name = invoice_params[:client_name]


    logopath = Rails.root.join('public', 'logo.png')
    initial_y = cursor
    initialmove_y = 5
    address_x = 35
    invoice_header_x = 325
    lineheight_y = 12
    font_size = 9

    move_down initialmove_y

    # Add the font style and size
    font "Helvetica"
    font_size font_size

    #start with EON Media Group
    text_box "#{business_name}", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "1234 Some Street Suite 1703", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "#{city}, ST 12345", :at => [address_x,  cursor]
    move_down lineheight_y

    last_measured_y = cursor
    move_cursor_to bounds.height

    image logopath, :width => 215, :position => :right

    move_cursor_to last_measured_y

    # client address
    move_down 65
    last_measured_y = cursor

    text_box "Client Business Name", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "#{client_name}", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "4321 Some Street Suite 1000", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "Some City, ST 12345", :at => [address_x,  cursor]

    move_cursor_to last_measured_y

    invoice_header_data = [ 
      ["Invoice #", "001"],
      ["Invoice Date", "December 1, 2011"],
      ["Amount Due", "$3,200.00 USD"]
    ]

    table(invoice_header_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(column(1), :align => :right)
      style(row(2).columns(0), :borders => [:top, :left, :bottom])
      style(row(2).columns(1), :borders => [:top, :right, :bottom])
    end

    move_down 45

    invoice_services_data = [ 
      ["Item", "Description", "Unit Cost", "Quantity", "Line Total"],
      ["Service Name", "Service Description", "320.00", "10", "$3,200.00"],
      [" ", " ", " ", " ", " "]
    ]

    table(invoice_services_data, :width => bounds.width) do
      style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
      style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(row(0).columns(0..-1), :borders => [:top, :bottom])
      style(row(0).columns(0), :borders => [:top, :left, :bottom])
      style(row(0).columns(-1), :borders => [:top, :right, :bottom])
      style(row(-1), :border_width => 2)
      style(column(2..-1), :align => :right)
      style(columns(0), :width => 75)
      style(columns(1), :width => 275)
    end

    move_down 1

    invoice_services_totals_data = [ 
      ["Total", "$3,200.00"],
      ["Amount Paid", "-0.00"],
      ["Amount Due", "$3,200.00 USD"]
    ]

    table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :font_style => :bold)
      style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(column(1), :align => :right)
      style(row(2).columns(0), :borders => [:top, :left, :bottom])
      style(row(2).columns(1), :borders => [:top, :right, :bottom])
    end

    move_down 25

    invoice_terms_data = [ 
      ["Terms"],
      ["Payable upon receipt"]
    ]

end
end