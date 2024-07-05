class TesteController < ApplicationController
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
  def senhas_nao_coincidem
    flash[:alert] = 'Senha e confirmação de senha não coincidem'
    redirect_to recuperar_senha_path
  end

  def tamanho_senha
    flash[:alert] = 'Senha não atende aos critérios de segurança'
    redirect_to recuperar_senha_path
  end
end


