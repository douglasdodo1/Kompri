class UsuariosController < ApplicationController
  before_action :authenticate_request!, only: %i[show index update destroy]
  before_action :set_usuario, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError,                with: :render_500
  def index
    @usuarios = Usuario.all
    render json: @usuarios, status: :ok
  end

  def show
    render json: @usuario, status: :ok, location: @usuario
  end

  def create
    @usuario = Usuario.create!(user_params)
    render json: @usuario, status: :created, location: @usuario
  end

  def update
    @usuario.update!(user_params)
    render json: @usuario, status: :ok, location: @usuario
  end

  def destroy
    @usuario.destroy!
    head :no_content
  end

  private
  def set_usuario
    @usuario = Usuario.find_by!(cpf: params.expect(:cpf))
  end

  def user_params
    params.expect(usuario: [ :cpf, :nome, :email, :password, :telefone ])
  end
end
