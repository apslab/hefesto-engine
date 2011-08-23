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
  has_many :comprobantes do 
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
    
  def control_sin_comprobantes
   if [comprobantes].any? {|cpbte| cpbte.any? }
     self.errors[:base] = "error que queres hacer?"
     return false
   end   
  end
end
