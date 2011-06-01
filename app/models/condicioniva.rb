# == Schema Information
# Schema version: 20110512124317
#
# Table name: condicionivas
#
#  id         :integer         not null, primary key
#  detalle    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  letra      :string(255)
#

class Condicioniva < ActiveRecord::Base
  has_many :clientes
  
  validates :detalle, :presence => true
  validates :letra, :presence => true
end
