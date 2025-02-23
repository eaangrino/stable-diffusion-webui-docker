CONTAINER_NAME=automatic1111

.PHONY: bash start control-net-fix

# Abrir una terminal en el contenedor
bash:
	docker exec -it $(CONTAINER_NAME) bash

# Iniciar Stable Diffusion dentro del contenedor
start:
	docker exec -it $(CONTAINER_NAME) bash -c "cd /home/sdwui/stable-diffusion-webui && ./webui.sh"

# Iniciar Stable Diffusion dentro del contenedor
start-venv:
	docker exec -it $(CONTAINER_NAME) bash -c "cd /home/sdwui/stable-diffusion-webui && source venv/bin/activate && ./webui.sh"

# Instalar insightface dentro del venv del contenedor
control-net-fix:
	docker exec -it $(CONTAINER_NAME) bash -c "cd /home/sdwui/stable-diffusion-webui && source venv/bin/activate && pip install insightface"
# docker exec -it $(CONTAINER_NAME) bash -c "cd /home/sdwui/stable-diffusion-webui && source venv/bin/activate && pip install --prefer-binary insightface==0.7.3"
