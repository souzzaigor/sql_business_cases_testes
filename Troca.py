#%%
import sqlite3

# 1. Abre a conexão com o banco de dados
conexao = sqlite3.connect('banco_souza.db')
cursor = conexao.cursor()

try:
    # 2. Exclui a tabela antiga que continha os valores nulos
    cursor.execute("DROP TABLE IF EXISTS transacoes;")
    print("Tabela antiga 'transacoes' excluída com sucesso.")

    # 3. Renomeia a tabela limpa para ocupar o lugar da original
    cursor.execute("ALTER TABLE transacoes_limpas RENAME TO transacoes;")
    print("Tabela 'transacoes_limpas' renomeada para 'transacoes' com sucesso!")
    
    # Salva as alterações no arquivo .db
    conexao.commit()

except sqlite3.Error as e:
    conexao.rollback()
    print(f"Erro ao modificar o banco: {e}")

finally:
    # 4. Fecha a conexão com segurança
    conexao.close()