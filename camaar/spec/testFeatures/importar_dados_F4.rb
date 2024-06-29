require 'rails_helper'

RSpec.describe 'Importação de dados do SIGAA', type: :system do

  #before do
  #  driven_by(:selenium_chrome_headless)
  #end

  #TRISTE
  it 'Falha na importação devido a seleção de arquivo inválido' do
    visit '/home'
    find('#menu-icon').click
    expect(find('#sidebar')).to be_visible
    click_link 'Gerenciamento'
    expect(find('#popup')).to be_visible
    find('#importar_dados_btn').click

    # Captura e lida com o alerta, se existir
    begin
      page.driver.browser.switch_to.alert.accept
    rescue Selenium::WebDriver::Error::NoAlertPresentError
      # Não faz nada se não houver alerta presente
    end

    expect(find('#popup-upload')).to be_visible

    # Simula a seleção de um arquivo não JSON para disciplins
    # (vamos usar um arquivo de texto)
    attach_file('file_input_disciplinas', Rails.root.join('textoTeste.txt'))
    # Aguarda um pequeno intervalo para permitir que o alerta apareça
    sleep 1
    # Verifica se o alerta foi exibido corretamente
    expect(page.driver.browser.switch_to.alert.text).to eq('O arquivo selecionado deve ser do tipo JSON.')

    # Aceita o alerta
    page.driver.browser.switch_to.alert.accept

    # Simula a seleção de um arquivo não JSON para membros
    # (vamos usar um arquivo de texto)
    attach_file('file_input_membros', Rails.root.join('textoTeste.txt'))
    # Aguarda um pequeno intervalo para permitir que o alerta apareça
    sleep 1
    # Verifica se o alerta foi exibido corretamente
    expect(page.driver.browser.switch_to.alert.text).to eq('O arquivo selecionado deve ser do tipo JSON.')
  end

  #TRISTE
  it 'Falha na importação devido a formato inválido do arquivo JSON' do
    visit '/home'
    find('#menu-icon').click
    expect(find('#sidebar')).to be_visible
    click_link 'Gerenciamento'
    expect(find('#popup')).to be_visible
    find('#importar_dados_btn').click

    # Captura e lida com o alerta, se existir
    begin
      page.driver.browser.switch_to.alert.accept
    rescue Selenium::WebDriver::Error::NoAlertPresentError
      # Não faz nada se não houver alerta presente
    end

    expect(find('#popup-upload')).to be_visible

    # Simula a seleção de um arquivo JSON com formato invalido
    attach_file('file_input_disciplinas', Rails.root.join('jsonErradoTeste.json'))
    # Aguarda um pequeno intervalo para permitir que o alerta apareça
    sleep 1
    # Verifica se o alerta foi exibido corretamente
    expect(page.driver.browser.switch_to.alert.text).to eq('O conteúdo do arquivo não está em formato JSON válido.')

    # Aceita o alerta
    page.driver.browser.switch_to.alert.accept

    attach_file('file_input_membros', Rails.root.join('jsonErradoTeste.json'))
    # Aguarda um pequeno intervalo para permitir que o alerta apareça
    sleep 1
    # Verifica se o alerta foi exibido corretamente
    expect(page.driver.browser.switch_to.alert.text).to eq('O conteúdo do arquivo não está em formato JSON válido.')

  end

  # FELIZ
  it 'Importar dados com sucesso a partir de um arquivo JSON' do
    visit '/home'
    find('#menu-icon').click
    expect(find('#sidebar')).to be_visible
    click_link 'Gerenciamento'
    expect(find('#popup')).to be_visible
    find('#importar_dados_btn').click

    # Captura e lida com o alerta, se existir
    begin
      page.driver.browser.switch_to.alert.accept
    rescue Selenium::WebDriver::Error::NoAlertPresentError
      # Não faz nada se não houver alerta presente
    end

    expect(find('#popup-upload')).to be_visible

    # Simula a seleção de um arquivo JSON com formato VALIDO
    attach_file('file_input_disciplinas', Rails.root.join('jsonCertoTeste.json'))

  end


end