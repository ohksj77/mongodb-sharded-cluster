#!/bin/bash

# Docker 엔진 실행 이후 이 스크립트를 실행해주세요.

docker-compose up -d

echo "MongoDB 안전한 실행을 위해 기다리는중..."

sleep 10

docker exec mongo-config mongo --port 27019 --eval '
rs.initiate(
  {
    _id: "configReplSet",
    configsvr: true,
    members: [
      { _id: 0, host: "mongo-config:27019" }
    ]
  }
)
'

until docker exec mongo-config mongo --port 27019 --eval 'rs.status()' | grep -q 'PRIMARY'; do
  sleep 1
done

docker exec mongo-shard1 mongo --port 27018 --eval '
rs.initiate(
  {
    _id: "shard1ReplSet",
    members: [
      { _id: 0, host: "mongo-shard1:27018" }
    ]
  }
)
'

until docker exec mongo-shard1 mongo --port 27018 --eval 'rs.status()' | grep -q 'PRIMARY'; do
  sleep 1
done

docker exec mongo-shard2 mongo --port 27020 --eval '
rs.initiate(
  {
    _id: "shard2ReplSet",
    members: [
      { _id: 0, host: "mongo-shard2:27020" }
    ]
  }
)
'

until docker exec mongo-shard2 mongo --port 27020 --eval 'rs.status()' | grep -q 'PRIMARY'; do
  sleep 1
done

until docker exec mongo-router mongo --port 27017 --eval 'db.runCommand({ping: 1})' | grep -q 'ok'; do
  sleep 1
done

docker exec mongo-router mongo --port 27017 --eval '
sh.addShard("shard1ReplSet/mongo-shard1:27018");
sh.addShard("shard2ReplSet/mongo-shard2:27020");
sh.enableSharding("testdb");
sh.shardCollection("testdb.testcollection", { "_id": "hashed" });
'

echo "Sharded MongoDB Cluster 구성 완료"
