Build 


'''docker buildx bake \
  --allow=fs.read=/root/projects/container/container-template \
  skyrl --no-cache --push
  
docker buildx bake skyrl --no-cache --push'''

run

'''
docker run --gpus all --rm -it \
  --entrypoint /start.sh \
  yottalabsai/skyrl-yotta:TAG
'''

