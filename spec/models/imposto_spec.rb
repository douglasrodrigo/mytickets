require 'spec_helper'
describe Imposto do
  before(:each) do
    @imposto = Imposto.create(:municipio_id => 1, :nome => "Imposto", :taxa => 0.5, :recolhimento => "Mensal")
  end
  it "should calculate imposto" do
    valor_bruto = BigDecimal.new("1000.50")
    valor_imposto = @imposto.calcular(valor_bruto)
    valor_imposto.should === BigDecimal.new("500.25")
  end
end
