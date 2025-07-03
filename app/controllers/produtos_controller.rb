class ProdutosController < ApplicationController
  before_action :authenticate_request!
  before_action :set_produto, only: %i[ show index update destroy ]
  
  def index
    @produtos = Produto.all
    render json: @produtos, status: :ok
  end

  def show
    render json: @produto, status: :ok, location: @produto
  end

  def create
    @produto = Produto.create!(produto_params)
    render json: @produto, status: :created, location: @produto
  end

  def update
    @produto.update!(produto_params)
    render json: @produto, status: :ok, location: @produto
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
