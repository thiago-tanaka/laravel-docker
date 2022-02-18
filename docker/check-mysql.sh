container_name=$(docker ps --filter name=app* -q)

while [ "$container_name" = "" ] ; do
    echo "waiting app container to be running."
    sleep 2
    container_name=$(docker ps --filter name=app* -q)
done

while ! docker exec -it "$container_name" mysqladmin ping -hmysql -uroot -psecret --silent; do
    echo 'waiting mysql connection...'
    sleep 2
done