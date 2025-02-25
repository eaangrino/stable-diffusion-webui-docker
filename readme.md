# README / Documentación

<!-- ## Índice / Contents
- [Español](#español)
- [English](#english) -->

<details>
  <summary>Español</summary>
  
  ### Paso 1: Clonar el repositorio
  ```sh
  git clone https://github.com/eaangrino/stable-diffusion-webui-docker.git
  ```
  
  ### Paso 2: Entrar a la carpeta del repositorio
  ```sh
  cd stable-diffusion-webui-docker
  ```
  
  ### Paso 3: Crear el archivo `webui.sh` en la carpeta `config`
  ```sh
  mkdir config && touch config/webui.sh
  ```
  Luego, edita el archivo `config/webui.sh` y agrega lo siguiente:
  ```sh
  install_dir="/home/$(whoami)/stable-diffusion-webui"
  python_cmd="python3"
  export GIT="git"
  venv_dir="venv"
  ```
  
  ### Paso 4: Ejecutar Docker Compose
  ```sh
  docker compose up -d --build && make start
  ```
  
  ### Paso 5: Acceder a la interfaz web
  Abre tu navegador y ve a:
  ```sh
  http://localhost:7860
  ```
  
</details>

<details>
  <summary>English</summary>
  
  ### Step 1: Clone the repository
  ```sh
  git clone https://github.com/eaangrino/stable-diffusion-webui-docker.git
  ```
  
  ### Step 2: Enter the repository folder
  ```sh
  cd stable-diffusion-webui-docker
  ```
  
  ### Step 3: Create the `webui.sh` file in the `config` folder
  ```sh
  mkdir config && touch config/webui.sh
  ```
  Then, edit the file `config/webui.sh` and add the following:
  ```sh
  install_dir="/home/$(whoami)/stable-diffusion-webui"
  python_cmd="python3"
  export GIT="git"
  venv_dir="venv"
  ```
  
  ### Step 4: Run Docker Compose
  ```sh
  docker compose up -d --build && make start
  ```
  
  ### Step 5: Access the web interface
  Open your browser and navigate to:
  ```sh
  http://localhost:7860
  ```
  
</details>
