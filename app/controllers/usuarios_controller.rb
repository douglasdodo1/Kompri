class UsuariosController < ApplicationController
  before_action :authenticate_request!, only: %i[show index update destroy]
  before_action :set_usuario, only: %i[ show update destroy ]

  def index
    @usuarios = Usuario.all
    render json: @usuarios, status: :ok
  end

  def show
    render json: @usuario, status: :ok, location: @usuario
  end

  def create
    @usuario = Usuario.new(user_params)
    @usuario.save! 
    render json: @usuario, status: :created
  end


  def update
    @usuario = usuario.update!(user_params)
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
