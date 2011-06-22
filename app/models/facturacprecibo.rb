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

class Facturacprecibo < ActiveRecord::Base
  belongs_to :facturacp
  belongs_to :recibocp
  has_one :supplier, :through => :facturacp

  scope :by_supplier, lambda {|supplier| where(:supplier_id => supplier) }
end
