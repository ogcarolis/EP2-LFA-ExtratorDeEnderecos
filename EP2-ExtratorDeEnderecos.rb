# Carolina Gimenez e Eduarda Medeiros

# Definição do texto de entrada
puts "Com base no modelo: Av. Eng. Eusébio Stevaux, 823 - Sala 13, Santo Amaro, São Paulo - SP, 04696-000"
puts "Insira um endereço: "
texto = gets.chomp 

# Expressão regular para extrair o endereço
# O CEP contém 5 dígitos no começo e 3 no final
endereco = texto.match(/(?<tipo>[A-zÀ-ú]+\.?)\s(?<logradouro>[A-zÀ-ú]+\.?(\s*[A-zÀ-ú]+)*)\,\s(?<numero>\d+)\s?\-?\s?(?<complemento>[A-zÀ-ú]+?\s?\d+?)?\,\s(?<bairro>([A-zÀ-ú]+\s?)+)\,\s(?<cidade>([A-zÀ-ú]+\s?)+)\s\-\s(?<estado>[A-Z]{2})\,\s(?<cep>\d{5}\-\d{3})/)

# Extrair os grupos correspondentes
if endereco
  puts 'Tipo: ' + endereco[:tipo]
  puts 'Logradouro: ' + endereco[:logradouro]
  puts 'Número: ' + endereco[:numero]
  if endereco[:complemento]
    puts 'Complemento: ' + endereco[:complemento]
  end
  puts 'Bairro: ' + endereco[:bairro]
  puts 'Cidade: ' + endereco[:cidade]
  puts 'Estado: ' + endereco[:estado]
  puts 'CEP: ' + endereco[:cep]
else 
  puts 'Endereço incorreto ou não encontrado.'
end

