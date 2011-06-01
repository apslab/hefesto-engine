# == Schema Information
# Schema version: 20110427202648
#
# Table name: facturanotacreditos
#
#  id             :integer         not null, primary key
#  factura_id     :integer
#  fecha          :date
#  importe        :decimal(, )
#  notacredito_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Facturanotacredito < ActiveRecord::Base
  belongs_to :factura
  belongs_to :notacredito
  has_one :cliente, :through => :factura
end
