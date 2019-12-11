# ox-irr-tools
Open X IRR Tools

 ------------------
 
## Descricao das ferramentas

 ------------------

 * ox_irr_config.pl

Configuração dos parametros para gerar os objetos nos scripts ox_irr_new_customer.pl e find-for-deletion.pl
  
 ------------------
 
  * ox_irr_new_customer.pl [-d] [-f] ASN [ASN...]

Consulta se os ASN informados já possuem registros já criados no IRR. Caso nao encontre registros válidos, gera o template para poder criá-los.

O flag -f força a geração dos templates (não verifica se eles já existem).

O flag -d mostra se alguma das rotas existe com a origem incorreta

------------------

* download.sh

Faz o download da ultima versão dos dados e salva em ox-irr-check-latest.csv. Este arquuivo será o parametro OX-IRR-CHECK-OUTPUT das outras ferramentas.
  
 ------------------
  
  * find-for-deletion.pl MAINT OX-IRR-CHECK-OUTPUT

Consulta se o MAINT informado possui algum objeto que poderia ser apagado, por ser INVALIDO (INVALID) ou DESNECESSARIO (UNEEDED), gerando os templates para remoção caso encontre algum. 

 ------------------
 
  * gerar-ranking-maint.pl OX-IRR-CHECK-OUTPUT

Lista todos os maintainers ordenados pela quantidade de objetos

 ------------------
 
  * gerar-ranking-source.pl OX-IRR-CHECK-OUTPUT

Lista todos as bases (SOURCES) ordenados pela quantidade de objetos

 ------------------
 
  * show-overall-status-summ.pl OX-IRR-CHECK-OUTPUT

Faz um resumo do processamento, agrupando todos os *STATUS* numa única linha.

 ------------------
 
  * show-overall-status.pl OX-IRR-CHECK-OUTPUT

Faz um resumo do processamento, com um *STATUS* por linha

 ------------------
 
 
