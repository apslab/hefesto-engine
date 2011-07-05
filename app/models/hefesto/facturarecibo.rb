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
module Hefesto
  class Facturarecibo < ActiveRecord::Base
    belongs_to :factura
    belongs_to :recibo
    has_one :supplier, :through => :factura

    scope :by_supplier, lambda {|supplier| where(:supplier_id => supplier) }
  end
end