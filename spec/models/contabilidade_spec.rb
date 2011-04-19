require 'spec_helper'

describe Contabilidade do
  before(:each) do
    @municipio = Municipio.create(:nome => "Municipio", :impostos => [
      Imposto.create(:nome => "Imposto Fonte", :taxa => BigDecimal.new("0.1"), :recolhimento => "fonte"),
      Imposto.create(:nome => "Imposto Mensal", :taxa => BigDecimal.new("0.2"), :recolhimento => "mensal"),
      Imposto.create(:nome => "Imposto Trimestral", :taxa => BigDecimal.new("0.5"), :recolhimento => "trimestral")
    ])
    @valor_bruto = BigDecimal.new("1000.50")

    @contabilidade = Contabilidade.new(@municipio, @valor_bruto)
    @valor_liquido_receber = @valor_bruto - (@valor_bruto * @municipio.impostos[0].taxa)
    @valor_mensal_liquido = @valor_liquido_receber - (@valor_bruto * @municipio.impostos[1].taxa)
    @valor_trimestral_liquido = @valor_mensal_liquido - (@valor_bruto * @municipio.impostos[2].taxa)
  end
  describe "criar contabilidade" do
    it "should have municipio and valor bruto" do
      @contabilidade.municipio.should_not be_nil
      @contabilidade.valor_bruto.should_not be_nil
    end

    it "should have impostos fonte" do
      @contabilidade.impostos_fonte[0].should == @municipio.impostos[0] 
    end

    it "should have impostos mensais" do
      @contabilidade.impostos_mensal[0].should == @municipio.impostos[1] 
    end

    it "should have impostos trimestrais" do
      @contabilidade.impostos_trimestral[0].should == @municipio.impostos[2] 
    end
  end
  
  describe "calcular impostos" do
    it "should have the right valor a receber" do
      @contabilidade.valor_liquido_receber.should === @valor_liquido_receber
    end

    it "should have the right valor mensal liquido" do
      @contabilidade.valor_mensal_liquido.should === @valor_mensal_liquido
    end

    it "should have the right valor trimestral liquido" do
      @contabilidade.valor_trimestral_liquido.should === @valor_trimestral_liquido
    end
  end
end
