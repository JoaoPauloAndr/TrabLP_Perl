use strict; 
use Sort::Key qw(keysort nkeysort ikeysort);

my $file = $ARGV[0] or die; 
open(my $data, '<', $file) or die; 
my $first_line = <$data>;
my $nvagas = 0;
my $total_votos = 0;
my @candidatos = ();
my @eleitos = ();

while (my $linha = <$data>) 
{ 
	chomp $linha; 

	my @colunas = split ";", $linha;
    my $ncandidato = $colunas[1];
    my $nome = $colunas[2];
    my $sigla = $colunas[3];
    my $coligacao = "";
    if(index($sigla, '-') != -1){
        chomp $sigla;
        my @ar_sigla = split "-", $sigla;
        $sigla = $ar_sigla[0];
        $sigla =~ s/\s+$//;
        $coligacao = $ar_sigla[1];
        $coligacao =~ s/^\s+//;
    }else{
        $sigla =~ s/\s+$//;
    }
    my $nvotos = $colunas[4];
    $nvotos =~ s/\.//g;
    my $votos_val = $colunas[5];
    chomp $votos_val;
    my @v = split " ", $votos_val;
    $votos_val = $v[0];
    $votos_val =~ s/\,/\./g;
    my %candidato = ('numero' => $ncandidato, 'nome' => $nome, 'partido' => $sigla, 'coligacao' => $coligacao, 'votos' => $nvotos, 'votosValidos' => $votos_val);
    push(@candidatos, \%candidato);
    #pegar informacoes para relatorio:
    $total_votos += $nvotos;
    if(index($colunas[0], '*') != -1){
        $nvagas += 1;
        push(@eleitos, \%candidato);    
    }else{
        $nvagas += 0;    
    } 
}
@candidatos = reverse nkeysort { $_->{votos} } @candidatos;
@eleitos = reverse nkeysort { $_->{votos} } @eleitos;

#Relatorio
print "Número de vagas: $nvagas\n\n";
print "Vereadores eleitos:\n";
my $i = 0;
for $i (0 .. $#eleitos){
    print $i+1, " - ";
    print "$eleitos[$i]{nome} "; 
    print "(", $eleitos[$i]{partido}, ", ", $eleitos[$i]{votos}, " votos)";
    if($eleitos[$i]{coligacao} eq ""){
        print "\n";
    }else{
        print " - Coligação: ", $eleitos[$i]{coligacao}, "\n"; 
    }
}
print "\nCandidatos mais votados (em ordem decrescente de votação e respeitando número de vagas):\n";

for $i (0 .. 14){
    print $i+1, " - ";
    print "$candidatos[$i]{nome} "; 
    print "(", $candidatos[$i]{partido}, ", ", $candidatos[$i]{votos}, " votos)";
    if($candidatos[$i]{coligacao} eq ""){
        print "\n";
    }else{
        print " - Coligação: ", $candidatos[$i]{coligacao}, "\n"; 
    }
}
print "\nTotal de votos nominais: $total_votos\n"; 
close $data or die "divulga.csv: $!";
