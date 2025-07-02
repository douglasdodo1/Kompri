class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,             with: :render_404
  rescue_from ActiveRecord::RecordInvalid,              with: :render_422
  rescue_from Auth::MissingTokenError,                  with: :render_401
  rescue_from JWT::ExpiredSignature,                    with: :render_401
  rescue_from Auth::UnauthorizedError,                  with: :render_401
  rescue_from Auth::InvalidCredentialsError,            with: :render_401
  rescue_from ActionController::ParameterMissing,       with: :render_400
  rescue_from StandardError,                            with: :render_500


  def authenticate_request!
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    raise Auth::MissingTokenError, "Token não fornecido" unless token

    decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
    raise JWT::ExpiredSignature if decoded["exp"] < Time.now.to_i

    @current_user = Usuario.find_by(email: decoded["email"])
  end

  private


  def render_400(exception)
    render json: {
      erro: "Parâmetro ausente ou inválido",
      mensagem: exception.message,
      tipo: exception.class.to_s
    }, status: :bad_request
  end

  def render_401(exception)
    render json: {
      erro: "Não autorizado",
      mensagem: exception.message,
      tipo: exception.class.to_s
    }, status: :unauthorized
  end

  def render_404(exception)
    model = exception.message[/Couldn't find (\w+)/, 1] || "Recurso"
    render json: {
      erro: "#{model} não encontrado",
      mensagem: exception.message,
      tipo: exception.class.to_s
    }, status: :not_found
  end

  def render_422(exception)
    model_name = exception.record&.model_name&.human || "Recurso"
    render json: {
      erro: "#{model_name} inválido",
      modelo: model_name,
      mensagens: exception.record&.errors&.full_messages || [exception.message],
      tipo: exception.class.to_s
    }, status: :unprocessable_entity
  end
  
  def render_500(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")

    render json: {
      erro: "Erro interno no servidor",
      mensagem: exception.message,
      tipo: exception.class.to_s
    }, status: :internal_server_error
  end
end
