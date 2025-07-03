class AuthController < ApplicationController

  def login
    usuario = Usuario.find_by(email: authenticate_params[:email])
    raise Auth::InvalidCredentialsError, "Credenciais invalidas" unless usuario

    authenticated = usuario.authenticate(authenticate_params[:password])
    raise Auth::InvalidCredentialsError, "Credenciais invalidas" unless authenticated

      payload = {
        email: usuario.email,
        exp: 2.hours.from_now.to_i
      }
      token = JWT.encode(payload, Rails.application.secret_key_base)
      render json: { token: token }, status: :ok

  end

   def authenticate_params
      params.expect(credenciais: [ :email, :password])
    end
end
