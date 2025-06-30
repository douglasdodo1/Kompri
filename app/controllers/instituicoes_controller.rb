class InstituicoesController < ApplicationController
  before_action :set_instituicao, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    @instituicoes = Instituicao.all
    render json: @instituicoes
  end

  def show
    render json: @instituicao
  end

  def create
    @instituicao = Instituicao.create!(instituicao_params)
    render json: @instituicao, status: :created, location: @instituicao
  end

  def update
    @instituicao = Instituicao.update(instituicao_params)
    render json: @instituicao
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
