# == Schema Information
# Table name: suppliers
#
#  id              :integer         not null, primary key
#  codigo          :string(255)
#  razonsocial     :string(255)
#  cuit            :string(255)
#  telefono        :string(255)
#  direccion       :string(255)
#  contacto        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  condicioniva_id :integer
#  company_id      :integer
#

class Supplier < ActiveRecord::Base
  has_many :facturas, :class_name => '::Hefesto::Factura'
  has_many :recibos, :class_name => '::Hefesto::Recibo'
  has_many :notacreditos, :class_name => '::Hefesto::Notacredito'
  has_many :comprobantes, :foreign_key => "cliente_id" do 
    def saldo
      fc = where("Type = 'Hefesto::Factura'").sum(:importe)
      nc = where("Type = 'Hefesto::Notacredito'").sum(:importe)
      rc = where("Type = 'Hefesto::Recibo'").sum(:importe)
      fc - nc - rc
    end
  end
   
  belongs_to :condicioniva
  belongs_to :account

  validates :cuit, :presence => true, :length => { :maximum => 11 }
  validates :razonsocial, :presence => true
  validates :codigo, :presence => true
  validates_uniqueness_of :codigo, :scope => [:company_id]
  validates_uniqueness_of :cuit, :scope => [:company_id]

  validates_numericality_of :cuit, :only_integer => true, :message => "solo numeros"

  attr_accessible :razonsocial, :condicioniva_id, :codigo, :cuit, :telefono, :direccion, :contacto, :company_id, :account_id

  scope :sin_telefono, where("suppliers.telefono = '' ")
  scope :no_actualizados, where("updated_at IS NULL" )
  scope :orden_alfabetico, order("suppliers.razonsocial")  
  scope :by_company, lambda {|company| where(:company_id => company.id) }
  
  delegate :saldo , :to => :comprobantes
  
  before_destroy :control_sin_comprobantes

  def save_ctacte_pdf_to(filename,entity)
    require 'prawn'
    pdf = Prawn::Document.new(:left_margin => 35, :top_margin => 35,:page_size   => "LETTER",
                              :page_layout => :portrait)
    offset = 0

    pdf.repeat(:all, :dynamic => true) do
      pdf.draw_text ("Cuenta corriente de " + entity.first.supplier.razonsocial + " impreso el " + Date.today.strftime("%d/%m/%Y")) , :at => [5,745],:style => :bold, :size => 10
      pdf.draw_text "Hoja Nro.: " + pdf.page_number.to_s.rjust(4,"0"), :at => [300, 745],:style => :bold, :size => 8
    end
    data = [["Fecha","Tipo Cp","Numero","Importe","Fecha Vto","impreso"],[] ]
    saldo = 0
    entity.each do |r|
       data << [r.fecha.blank? ? '' : r.fecha.strftime("%d/%m/%Y"),
                r.type,
                r.numero,
                r.total_comprobante,
                r.fechavto.blank? ? '' : r.fechavto.strftime("%d/%m/%Y"),
                r.printed_at.blank? ? '' : r.printed_at.strftime("%d/%m/%Y")]
        saldo += r.total_comprobante       
    end
    data << ["" ,"Totales","",saldo.to_s,"",""  ]

    pdf.table(data, :column_widths => [65, 100, 60, 65, 65, 65],
             :cell_style => { :font => "Times-Roman",
                              :size => 10,:padding => [2,3,4,2],
                              :align =>  :left,
                              :valign => :center },
             :header => true ,
             :row_colors => ["F0F0F0", "FFFFCC"]
              ) do
      column(2...3).align = :right
      row(0).column(0..6).align = :center
    end
    pdf.render_file(filename)
  end
    
  def control_sin_comprobantes
   if [comprobantes].any? {|cpbte| cpbte.any? }
     self.errors[:base] = "error que queres hacer?"
     return false
   end   
  end
end
