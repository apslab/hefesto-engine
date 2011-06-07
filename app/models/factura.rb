# == Schema Information
# Schema version: 20110516183603
#
# Table name: comprobantes
#
#  id         :integer         not null, primary key
#  cliente_id :integer
#  type       :string(255)
#  fecha      :date
#  importe    :decimal(, )
#  numero     :integer
#  fechavto   :date
#  printed_at :date
#  created_at :datetime
#  updated_at :datetime
#

class Factura < Comprobante
  has_many :facturarecibos
  has_many :facturanotacreditos
  
  scope :no_actualizados, where("updated_at IS NULL" )
  scope :vencidas, where("fechavto < ?", Date.today)
  scope :por_cliente, lambda {|cliente| where(:cliente_id => cliente) }


  def total_comprobante
    self.total_factura
  end
  
  def total_iva_factura
    #facturadetalles.sum("preciounitario * cantidad * (1+(tasaiva/100))") 
    detalles.all.sum(&:totalivaitem)
  end

  def isprinted?
    printed_at?
  end
  
  def total_monto_cancelado
    self.facturarecibos.all.sum(&:importe) + self.facturanotacreditos.sum(&:importe)
  end
  
  def total_monto_adeudado
    self.total_factura - self.total_monto_cancelado
  end
  
#contabilizar
=begin
  def factura_total
    account_by_part(_method_)
  end  

  def factura_subtotal
    account_by_part(_method_)    
  end
  
  def factura_impuesto
    account_by_part(_method_)    
  end
=end
  
  # ['factura_total','factura_subtotal','factura_impuesto']
  Comprobante.referencias.grep(/^factura_/).each do |methodname|
    def_method(methodname,"account_by_part(_method_)")    
  end

  def account_by_part(referencename)
    self.cliente.empresa.refenciacontables.find_by_referencename(referencename).account_id
  end
end
