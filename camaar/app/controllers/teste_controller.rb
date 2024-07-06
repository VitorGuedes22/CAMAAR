# == TesteController
#
# Este controlador é responsável por testar a criação de sessões e definir senhas para usuários.
#
# === Ações Públicas
# - teste_create
# - definir_senha
#
# === Métodos Privados
# - senhas_nao_coincidem
# - tamanho_senha

class TesteController < ApplicationController
  # POST /teste_create
  #
  # Autentica o usuário com base no nome de usuário e senha fornecidos.
  #
  # ==== Parâmetros
  # - +params[:username]+ - O nome de usuário do usuário.
  # - +params[:password]+ - A senha do usuário.
  #
  # ==== Exemplo de resposta
  # - Redireciona para a página de login com uma mensagem de sucesso se a autenticação for bem-sucedida.
  # - Redireciona para a página de login com uma mensagem de erro se a autenticação falhar.
  def teste_create
    username = params[:username]
    password = params[:password]

    user = User.find_by(usuario: username)

    if user && user.senha == password
      redirect_to login_path, notice: 'Login realizado com sucesso!'
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to login_path
    end
  end

  # POST /definir_senha
  #
  # Define uma nova senha para o usuário com base no nome de usuário e senha fornecidos.
  #
  # ==== Parâmetros
  # - +params[:username]+ - O nome de usuário do usuário.
  # - +params[:new_password]+ - A nova senha do usuário.
  # - +params[:new_password_confirmation]+ - A confirmação da nova senha do usuário.
  #
  # ==== Exemplo de resposta
  # - Redireciona para a página de login com uma mensagem de sucesso se a senha for definida com sucesso.
  # - Redireciona para a página de recuperação de senha com uma mensagem de erro se a senha não atender aos critérios de segurança ou as senhas não coincidirem.
  def definir_senha
    @username = params[:username]
    @password = params[:new_password]
    @newPassword = params[:new_password_confirmation]

    user = User.find_by(usuario: @username)

    if @password != @newPassword
      senhas_nao_coincidem
    elsif @password.length < 1
      tamanho_senha
    else
      if user.update(password: @password)
        redirect_to login_path, notice: 'Definir senha com sucesso'
      else
        flash.now[:alert] = 'Definir senha SEM sucesso'
        redirect_to recuperar_senha_path
      end
    end
  end

  private

  # Método privado para lidar com o caso em que as senhas não coincidem.
  #
  # Redireciona para a página de recuperação de senha com uma mensagem de erro.
  def senhas_nao_coincidem
    flash[:alert] = 'Senha e confirmação de senha não coincidem'
    redirect_to recuperar_senha_path
  end

  # Método privado para lidar com o caso em que a senha não atende aos critérios de segurança.
  #
  # Redireciona para a página de recuperação de senha com uma mensagem de erro.
  def tamanho_senha
    flash[:alert] = 'Senha não atende aos critérios de segurança'
    redirect_to recuperar_senha_path
  end
end
