class ComprasController < ApplicationController
  before_action :set_compra, only: %i[ show update destroy ]

  def index
    @compras = Compra.all

    render json: @compras
  end

  def show
    render json: @compra
  end

  def create
    @compra = Compra.create!(compra_params)
    render json: @compra, status: :created, location: @compra
    
  end

  def update
    @compra  = Compra.update!(compra_params)
    render json: @compra
  end

  def destroy
    @compra.destroy!
  end

  private
    def set_compra
      @compra = Compra.find(params.expect(:id))
    end

    def compra_params
      params.expect(compra: [ :user_id, :status, :instituicao_id, :valor_total, :valor_estimado, :qtd_itens ])
    end
end
