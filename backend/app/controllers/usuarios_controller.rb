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
    @usuario = Usuario.create!(usuario_params)
    render json: @usuario, status: :created, location: @usuario
  end


  def update
    @usuario = Usuario.find_by!(email: params[:email])
    @usuario.update!(usuario_params)
    keys_enviadas = usuario_params.keys.map(&:to_s)
    chaves_alteradas = @usuario.previous_changes.keys
    .map(&:to_s)
    .reject { |k| k == "updated_at" }
    resultado = @usuario.as_json(only: keys_enviadas)
    resultado.merge!("password" => "Alterado com sucesso") if chaves_alteradas.include?("password_digest")
    render json: resultado, status: :ok, location: @usuario
  end

  def destroy
    @usuario.destroy!
    head :no_content
  end

  private
  def set_usuario
    @usuario = Usuario.find_by!(email: params[:email])
  end

  def usuario_params
    params.expect(usuario: [ :email, :nome, :password])
  end
end
