# TrabLP_Perl
Instruções para rodar o trabalho

Primeiramente, baixar e instalar Perl usando o seguinte comando no terminal:
curl -L http://xrl.us/installperlnix | bash (Ubuntu)
curl -L http://xrl.us/installperlosx | bash (macOS)
 
No trabalho usamos um módulo que precisa ser instalado via a ferramenta cpan que, por sua vez, é instalada com o comando:
cpan App::cpanminus (Ubuntu e macOS)

Após a instalação, o módulo usado no trabalho pode ser baixado e instalado digitando num terminal:
cpanm Sort::Key

Feito isso, agora o trabalho pode ser rodado:
perl trab.pl caminho_ate_arquivo/divulga.csv

O trabalho recebe um arquivo como parâmetro, no caso, o arquivo "divulga.csv".
