class InstituicoesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_instituicao, only: %i[ show index update destroy ]

  def index
    @instituicoes = Instituicao.all
    render json: @instituicoes, status: :ok
  end

  def show
    render json: @instituicao, status: :ok, location: @instituicao
  end

  def create
    @instituicao = Instituicao.create!(instituicao_params)
    render json: @instituicao, status: :created, location: @instituicao
  end

  def update
    @instituicao.update(instituicao_params)
    render json: @instituicao, status: :ok, location: @instituicao
  end

  def destroy
    @instituicao.destroy!
    head :no_content
  end

  private
    def set_instituicao
      @instituicao = Instituicao.find(params.expect(:id))
    end

    def instituicao_params
      params.expect(instituicao: [ :nome ])
    end
end
