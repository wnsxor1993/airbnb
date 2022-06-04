# 가동중인 jpa-shop 도커 중단 및 삭제
sudo docker ps -a -q --filter "name=airbnb" | grep -q . && docker stop airbnb && docker rm airbnb | true

# 기존 이미지 삭제
sudo docker rmi philsogood/airbnb:1.0

# 도커허브 이미지 pull
sudo docker pull philsogood/airbnb:1.0

# 도커 run
sudo docker run -d -p 80:8080 --name airbnb philsogood/airbnb:1.0

# 사용하지 않는 불필요한 이미지 삭제 -> 현재 컨테이너가 물고 있는 이미지는 삭제되지 않습니다.
sudo docker rmi -f $(docker images -f "dangling=true" -q) || true
