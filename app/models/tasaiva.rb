# == Schema Information
# Schema version: 20110427212004
#
# Table name: tasaivas
#
#  id          :integer         not null, primary key
#  detalle     :string(255)
#  porcentaje  :decimal(, )
#  vencimiento :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Tasaiva < ActiveRecord::Base
end
