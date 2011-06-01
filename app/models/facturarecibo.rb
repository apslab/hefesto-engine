# == Schema Information
# Schema version: 20110427202648
#
# Table name: facturarecibos
#
#  id         :integer         not null, primary key
#  factura_id :integer
#  fecha      :date
#  importe    :decimal(, )
#  recibo_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Facturarecibo < ActiveRecord::Base
  belongs_to :factura
  belongs_to :recibo
  has_one :cliente, :through => :factura

  scope :por_cliente, lambda {|cliente| where(:cliente_id => cliente) }
  
  #TODO facturarecibo, tiene relaciones con muchas facturas y muchos recibos
end
