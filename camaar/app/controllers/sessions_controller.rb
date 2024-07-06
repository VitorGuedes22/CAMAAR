# == SessionsController
#
# Este controlador é responsável por gerenciar as sessões de usuário, incluindo login, verificação de usuário e logout.
#
# === Ações Públicas
# - new
# - verify_user
# - create
# - destroy
#
# === Métodos Privados
# - user_nil
# - user_sem_senha
# - senha_certa
# - senha_errada

class SessionsController < ApplicationController
  # GET /login
  #
  # Renderiza a página de login.
  #
  # ==== Exemplo
  #   # Exibe a página login.html.erb
  def new
    # Ação para renderizar a página de login (login.html.erb)
  end

  # POST /verify_user
  #
  # Verifica se um usuário existe com base no nome de usuário fornecido.
  #
  # ==== Parâmetros
  # - +params[:username]+ - O nome de usuário a ser verificado.
  #
  # ==== Exemplo de resposta
  # - JSON: { found: true, url: '/recuperar_senha?username=username' }
  # - JSON: { found: false, message: 'Usuário não encontrado' }
  def verify_user
    username = params[:username]
    user = User.find_by(usuario: username)

    if user
      render json: { found: true, url: recuperar_senha_path(username: username) }
    else
      render json: { found: false, message: 'Usuário não encontrado' }
    end
  end

  # POST /login
  #
  # Autentica o usuário com base no nome de usuário e senha fornecidos.
  #
  # ==== Parâmetros
  # - +params[:username]+ - O nome de usuário do usuário.
  # - +params[:password]+ - A senha do usuário.
  #
  # ==== Exemplo de resposta
  # - Redireciona para a home page se o login for bem-sucedido.
  # - Redireciona para a página de recuperação de senha se a senha estiver em branco e o usuário não tiver senha.
  # - Redireciona para a página de login com uma mensagem de erro se o nome de usuário ou a senha estiver incorreto.
  def create
    user = User.find_by(usuario: params[:username])

    if user.nil?
      user_nil
    elsif params[:password].blank? && user.senha.nil?
      user_sem_senha
    elsif user.senha == params[:password]
      senha_certa(user)
    else
      senha_errada
    end
  end

  # DELETE /logout
  #
  # Encerra a sessão do usuário atual.
  #
  # ==== Exemplo de resposta
  # - Redireciona para a página de login com uma mensagem de sucesso.
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Você saiu com sucesso."
    redirect_to login_path
  end

  private

  # Método privado para lidar com o caso em que o usuário não é encontrado.
  #
  # Redireciona para a página de login com uma mensagem de erro.
  def user_nil
    flash[:alert] = "Usuário não encontrado. Por favor, verifique o usuário informado."
    redirect_to login_path
  end

  # Método privado para lidar com o caso em que o usuário não tem senha e a senha fornecida está em branco.
  #
  # Redireciona para a página de recuperação de senha.
  def user_sem_senha
    redirect_to recuperar_senha_path(username: params[:username])
  end

  # Método privado para lidar com o caso em que a senha fornecida está correta.
  #
  # Armazena o ID do usuário na sessão e redireciona para a home page com uma mensagem de sucesso.
  #
  # ==== Parâmetros
  # - +user+ - O usuário autenticado.
  def senha_certa(user)
    flash[:notice] = "Login realizado com sucesso!"
    session[:user_id] = user.id # Armazenar o ID do usuário na sessão
    redirect_to home_path
  end

  # Método privado para lidar com o caso em que a senha fornecida está incorreta.
  #
  # Redireciona para a página de login com uma mensagem de erro.
  def senha_errada
    flash[:alert] = "Senha incorreta. Por favor, verifique sua senha."
    redirect_to login_path
  end
end
