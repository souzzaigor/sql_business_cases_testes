#%%
import sqlite3
import pandas as pd
import random
from datetime import datetime
#%%
# 1. Conectando ao seu banco de dados atual
conexao = sqlite3.connect('banco_souza.db')

# 2. Lendo os dados atuais para descobrirmos os últimos IDs usados
df_clientes_atuais = pd.read_sql('SELECT * FROM clientes', conexao)
df_transacoes_atuais = pd.read_sql('SELECT * FROM transacoes', conexao)

# Pegando o maior ID atual para continuar a contagem de onde parou
ultimo_id_cliente = df_clientes_atuais['id_cliente'].max() if not df_clientes_atuais.empty else 0
ultimo_id_transacao = df_transacoes_atuais['id_transacao'].max() if not df_transacoes_atuais.empty else 0

# 3. Fabricando 30 NOVOS Clientes (Score de crédito aleatório)
novos_clientes = []
for i in range(1, 31): # Modificado para gerar 30 clientes
    id_novo = int(ultimo_id_cliente + i)
    data_abertura = datetime(2024, random.randint(1, 5), random.randint(1, 28)).strftime('%Y-%m-%d')
    score = round(random.uniform(300, 950), 2)
    novos_clientes.append([id_novo, data_abertura, score])

df_novos_clientes = pd.DataFrame(novos_clientes, columns=['id_cliente', 'data_abertura_conta', 'score_credito'])

# 4. Fabricando 150 NOVAS Transações (Misturando clientes antigos e novos)
todos_ids = list(df_clientes_atuais['id_cliente']) + list(df_novos_clientes['id_cliente'])

novas_transacoes = []
for i in range(1, 151): # Modificado para gerar 150 transações
    id_trans_novo = int(ultimo_id_transacao + i)
    cliente_sorteado = random.choice(todos_ids)
    data_transacao = datetime(2024, 5, random.randint(1, 30)).strftime('%Y-%m-%d')
    valor = round(random.uniform(15.50, 4500.00), 2)
    status = random.choice(['Aprovada', 'Aprovada', 'Aprovada', 'Negada']) 
    novas_transacoes.append([id_trans_novo, cliente_sorteado, data_transacao, valor, status])

df_novas_transacoes = pd.DataFrame(novas_transacoes, columns=['id_transacao', 'id_cliente', 'data_transacao', 'valor', 'status'])

# 5. Anexando no final das tabelas sem apagar o passado
df_novos_clientes.to_sql('clientes', conexao, if_exists='append', index=False)
df_novas_transacoes.to_sql('transacoes', conexao, if_exists='append', index=False)

conexao.close()
print("SUCESSO! 30 novos clientes e 150 novas transações foram injetados no seu banco_souza.db!")

