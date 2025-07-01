class ComprasController < ApplicationController
  before_action :authenticate_request!
  before_action :set_compra, only: %i[ show index update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError,                with: :render_500
  def index
    @compras = Compra.all
    render json: @compras.to_json(
      include: {
        instituicao: { only: [:nome] }
      }
    ), status: :ok
  end

  def show
    render json: @compra.to_json(
      include: {
        instituicao: { only: [:nome] }
      }
    ), status: :ok, location: @compra
  end

  def create
    @compra = Compra.create!(compra_params)
    render json: @compra.to_json(
      include: {
        instituicao: { only: [:nome] }
      }
    ), status: :created, location: @compra
  end

    def update
      @compra.update!(compra_params)
      render json: @compra.to_json(
        include: {
          instituicao: { only: [:nome] }
        }
      ), status: :ok, location: @compra
    end


  def destroy
    @compra.destroy!
    head :no_content
  end

  private
    def set_compra
      @compra = Compra.find(params.expect(:id))
    end

    def compra_params
      params.expect(compra: [ :usuario_cpf, :status, :instituicao_id, :valor_total, :valor_estimado, :qtd_itens ])
    end
end
