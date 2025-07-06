# Define a imagem base do Python com uma versão específica e uma distribuição Linux leve (Alpine).
# Isso resulta em uma imagem final menor e mais eficiente.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner. Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# Copia o arquivo de requirements.txt para o diretório de trabalho.
# Este arquivo contém as dependências do projeto que precisam ser instaladas.
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt usando o pip.
# A flag --no-cache-dir impede o pip de usar o cache, garantindo que as versões mais recentes das dependências sejam instaladas.
# A flag -r especifica o arquivo de requirements.txt como a fonte das dependências.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código do projeto para o diretório de trabalho dentro do contêiner.
# Isso inclui todos os arquivos e pastas necessários para executar a aplicação.
COPY . .

EXPOSE 8000

# Define o comando padrão a ser executado quando o contêiner for iniciado.
# Neste caso, estamos usando o Uvicorn, um servidor ASGI, para executar a aplicação FastAPI.
# O argumento "app:app" especifica que o Uvicorn deve procurar por um objeto chamado "app" no arquivo "app.py".
# A flag --host 0.0.0.0 permite que a aplicação seja acessada de fora do contêiner, em qualquer endereço IP.
# A flag --port 8000 define a porta na qual a aplicação estará disponível dentro do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
