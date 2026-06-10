#%%
import pandas as pd
import sqlite3
#%%
conexao = sqlite3.connect('banco_souza.db')

df_transacoes = pd.read_sql_query("SELECT * FROM transacoes", conexao)
#%%
print("------ Dados Originais extraídos ------")
print(df_transacoes.head())
print("\nQuantos nulos temos por coluna antes do tratamento")
print(df_transacoes.isnull().sum())

# Criando um dicionário com os valores que vão substituir os nulos
valores_preenchimento = {
    'categoria_compra': 'Não Informado',
    'canal_venda': 'Outros'
}
#%%
# O comando .fillna() encontra os nulos e substitui com base no nosso dicionário
# O inplace=True aplica a mudança direto no DataFrame atual
df_transacoes.fillna(value=valores_preenchimento, inplace=True)

print("\n--- Após a Limpeza com Pandas ---")
print("Quantidade de nulos agora:")
print(df_transacoes.isnull().sum())

# ==========================================
# 3. CARGA (L do ETL) - Salvando os dados limpos
# ==========================================
# Se quiser salvar essa tabela limpa de volta no banco com outro nome:
df_transacoes.to_sql('transacoes_limpas', conexao, if_exists='replace', index=False)

conexao.close()
print("\nETL Finalizado com Sucesso! Tabela 'transacoes_limpas' criada no banco.")