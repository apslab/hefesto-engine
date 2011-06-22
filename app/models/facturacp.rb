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

class Facturacp < Comprobantecp
  has_many :facturacprecibos
  has_many :facturacpnotacreditos
  
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
    define_method(methodname) { account_by_part(__method__) }    
  end

  Comprobante.referencias.grep(/^factura_/).each do |methodname|
    define_method(methodname) { account_by_part_debit(__method__ + 'debit?') }    
  end

  Comprobante.referencias.grep(/^factura_/).each do |methodname|
    define_method(methodname) { account_by_part_credit(__method__ + 'credit?') }    
  end

  def account_by_part(referencename)
    self.cliente.empresa.refenciacontables.find_by_referencename(referencename).account_id
  end

  def account_by_part_debit(referencename)
    self.cliente.empresa.refenciacontables.find_by_referencename(referencename).debita
  end

  def account_by_part_credit(referencename)
    not self.cliente.empresa.refenciacontables.find_by_referencename(referencename).debita
  end
    
  def to_entry
    Entry.new do |entry|
      entry.date_to = Date.today
      # cada referencia es mapeada al asiento
      Comprobante.referencias.grep(/^factura_/).each do |methodname|
        entry.details.new
        entry.details.account_id = self.factura_total()
        entry.details.description = methodname.to_s
        entry.details.credit = total_factura if self.factura_total_credit?
        entry.details.debit = total_factura if self.factura_total_debit?

        entry.details.new
        entry.details.account_id = self.factura_subtotal()
        entry.details.description = methodname.to_s
        entry.details.credit = subtotal_factura if self.factura_subtotal_credit?
        entry.details.debit = subtotal_factura if self.factura_subtotal_debit?

        entry.details.new
        entry.details.account_id = self.factura_iva()
        entry.details.description = methodname.to_s
        entry.details.credit = total_iva_factura if self.factura_iva_credit?
        entry.details.debit = total_iva_factura if self.factura_iva_debit?
      end
    end
    return entry
  end
end

=begin
aqui en Factura

def to_entry
  returnig Entry.new do |Entry|
  # empiezo el mapping de
  entry.attributo = selffactura.elatributoquelocompleta
  end
end

de esa forma dado que tenes una factura
fac = Factura.first
llegas a su entry de contabilidad
asi
fac.to_entry
eso devuelve un objecto entry, listo para ser salvado
o lo que fuere
me explique o es medio chino?
lo piola de este approach es que te queda todo encapsulado en el modelo
es como hacer la factura xml
o jston
to_json, o to_xml
bueno aca es hacer la factura una entry de contable
to_entry

me quede pensando
no necesitas returning en este caso
poirque
Entry.new do |entry|
# inicializacion loca de entry
end
devuelve un obj Entry
=end
