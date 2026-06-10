#%%
import pandas as pd
#%%
df1 = pd.read_csv("CLIENTES.csv")
#%%
df2 = pd.read_csv("TRANSACOES.csv")
# %%
df_junto = pd.merge(df1, df2, on = 'id_cliente', how= "inner")
df_junto.head()
# %%
df_junto['score_credito'] = df_junto['score_credito'].fillna(df_junto['score_credito'].mean())
df_junto.head()
# %%
filtro = df_junto['status'] == 'Negada'
df_junto[filtro]
df_negat = df_junto[filtro]
# %%
df_resul = df_negat.groupby('score_credito')["valor"].mean()
df_resul.head()