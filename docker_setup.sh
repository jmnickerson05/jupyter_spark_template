#docker pull jupyter/pyspark-notebook
app="pyspark_lab"
if docker ps | awk -v app="$app" 'NR > 1 && $NF == app{ret=1; exit} END{exit !ret}'; then
  output="$(docker stop "$app" && docker rm -f "$app")"
fi
mnt_point="`pwd`/dev" 
echo "$mnt_point"
docker_output="$(docker run -d -v $mnt_point:/home/jovyan/work -p 8888:8888 -p 4040:4040 -p 4041:4041 --name pyspark_lab jupyter/pyspark-notebook)" 
sleep 3
jupyter_url="$(docker exec  pyspark_lab jupyter notebook list | grep -o 'http\S*\W')"
echo "$juptyer_url"
open "$jupyter_url"
