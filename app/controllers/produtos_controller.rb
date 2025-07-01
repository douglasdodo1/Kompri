class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError,                with: :render_500
  def index
    @produtos = Produto.all
    render json: @produtos
  end

  def show
    render json: @produto
  end

  def create
    @produto = Produto.create!(produto_params)
    render json: @produto
  end

  def update
    @produto.update!(produto_params)
    render json: @produto
  end

  def destroy
    @produto.destroy!
    head :no_content
  end

  private
    def set_produto
      @produto = Produto.find(params.expect(:id))
    end

    def produto_params
      params.expect(produto: [ :nome, :marca, :categoria ])
    end
end
