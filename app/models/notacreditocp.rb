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

class Notacreditocp < Comprobantecp
  has_many :facturacpnotacreditos
    
  def total_notacredito
    self.importe
  end
  
  def total_comprobante
    (self.importe * -1)
  end
end
