# sudo apt install -y python3.9
echo "export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:24" >> ~/.bashrc
echo "export MODELSCOPE_CACHE=/data/system/cache/modelscope/hub" >> ~/.bashrc
echo "export PYOPENGL_PLATFORM=osmesa" >> ~/.bashrc
echo "export TORCH_HOME=/data/torch/" >> ~/.bashrc
echo "export HF_ENDPOINT='https://hf-mirror.com'" >> ~/.bashrc
echo "export HF_HOME='/data/system/cache/huggingface/'" >> ~/.bashrc
