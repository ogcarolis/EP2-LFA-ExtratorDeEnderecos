# Definição da função extrator
def Extrator(texto)
  # Define expressões regulares para diferentes componentes do endereço
  # O CEP contém 5 dígitos no começo e 3 no final
  tipo = /(?<tipo>(A|a)eroporto|(A|a)lameda|(Á|á)rea|(A|a)venida|(A|a)v\.|(C|c)ampo|(C|c)hácara|(C|c)olônia|(C|c)ondomínio|(C|c)onjunto|(D|d)istrito|(E|e)splanada|(E|e)stação|(E|e)strada|(F|f)avela|(F|f)azenda|(F|f)eira|(J|j)ardim|(L|l)adeira|(L|l)ago|(L|l)agoa|(L|l)argo|(L|l)oteamento|(M|m)orro|(N|n)úcleo|(P|p)arque|(P|p)assarela|(P|p)átio|(P|p)raça|(Q|q)uadra|(R|r)ecanto|(R|r)esidencial|(R|r)odovia|(R|r)ua|(S|s)etor|(S|s)ítio|(T|t)ravessa|(T|t)recho|(T|t)revo|(V|v)ale|(V|v)ereda|(V|v)ia|(V|v)iaduto|(V|v)iela|(V|v)ila)/
  logradouro = /\s(?<logradouro>([A-zÀ-ú]+\.?\s*)+)/
  numero = /\,?\s(?<numero>\d+)/
  complemento = /(\s\-\s)*\,?\s?(?<complemento>[A-zÀ-ú]+?\s?\d+?)?/
  bairro = /\,?\s?\-?\s?(?<bairro>([A-zÀ-ú]+\s?)+)?/
  cidade = /\,?\s?(?<cidade>([A-zÀ-ú]+\s?)+)?/
  estado = /\,?\s\-?\s?(?<estado>[A-z]{2})?/
  cep = /\,?\s(?<cep>\d{5}\-\d{3})?/
  
  # Extrair os grupos correspondentes
  
  # Grupo 1: parte obrigatória para conter um endereço no texto
  end_obrigatorio = texto.match("#{tipo}#{logradouro}#{numero}#{complemento}")
  
  # Parte que deleta tudo que vem antes do primeiro grupo
  if end_obrigatorio
    endereco = end_obrigatorio[0]
    texto.sub!(/.*#{Regexp.quote(endereco)}/, "")
  end
  
  puts texto
  
  if end_obrigatorio
    puts 'Tipo: ' + end_obrigatorio[:tipo].capitalize
    puts 'Logradouro: ' + end_obrigatorio[:logradouro].split(/ |\_/).map(&:capitalize).join(" ")
    puts 'Número: ' + end_obrigatorio[:numero]
    
    # texto = texto.gsub(end_obrigatorio.to_s,"")
    if end_obrigatorio[:complemento]
      puts 'Complemento: ' + end_obrigatorio[:complemento].capitalize
    else
      puts 'Complemento: Não informado'
    end
    texto = texto.gsub(end_obrigatorio.to_s,"")
  
    end_bairro = texto.match("#{bairro}")
  
    # Grupo 2: parte opcional para conter um bairro no texto
    if end_bairro
      if end_bairro[:bairro]
        puts 'Bairro: ' + end_bairro[:bairro].split(/ |\_/).map(&:capitalize).join(" ")
        texto = texto.gsub(end_bairro.to_s,"")
      else 
        puts 'Bairro: Não informado'
      end
    end
  
    end_cid_est = texto.match("#{cidade}#{estado}")
  
    # Grupo 3: parte opcional para conter uma cidade e um estado no texto
    if end_cid_est 
      if end_cid_est[:cidade]
        puts 'Cidade: ' + end_cid_est[:cidade].split(/ |\_/).map(&:capitalize).join(" ")
      else
        puts 'Cidade: Não informado'
      end
  
      if end_cid_est[:estado]
        puts 'Estado: ' + end_cid_est[:estado].upcase
      else
        puts 'Estado: Não informado'
      end
      texto = texto.gsub(end_cid_est.to_s,"")
    else
      puts 'Cidade: Não informado'
      puts 'Estado: Não informado'
    end
      
    end_cep = texto.match("#{cep}")
  
    # Grupo 4: parte opcional para conter um CEP no texto
    if end_cep
      if end_cep[:cep]
        puts 'CEP: ' + end_cep[:cep]
      end
    else
      puts 'CEP: Não informado'
    end
  else
    puts 'Endereço não encontrado.'
  end
end  

# Exemplo de uso
# Definição do texto de entrada

# puts "Insira uma mensagem contendo um endereço: "
# texto = gets.chomp 

texto = "Boa tarde! Eu moro na Av. Eng. Eusébio Stevaux, 823 - Santo Amaro, São Paulo - SP, 04696-000"

puts "Exemplo 1: " + texto
Extrator(texto)

texto = "Rua do Estilo Barroco, 573, Apto 1 - Chácara Santo Antônio, São Paulo - SP, 04709-011"

puts "\nExemplo 2: " + texto
Extrator(texto)

texto = "Estou na rua george saulo 42" 

puts "\nExemplo 3: " + texto
Extrator(texto)