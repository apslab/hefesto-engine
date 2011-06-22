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

class Recibocp < Comprobantecp
  has_many :facturacprecibos
  
  def total_recibo
    self.importe
  end
  
  def total_comprobante
    (self.importe * -1)
  end
  
protected
  #def calculo_total_comprobante
  #  self.importe =  8888
  #end   
end
