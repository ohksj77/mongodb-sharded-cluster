# mongodb-sharded-cluster
MongoDB 클러스터와 샤딩을 구성해보자

## 실행
```
sh ./run.sh
```

## 결과

- 라우팅 역할의 인스턴스에서는 모든 저장 데이터를 확인할 수 있다.
![](https://github.com/ohksj77/mongodb-sharded-cluster/assets/89020004/ca991710-b8ab-4705-9471-4d84ff3aed2f)

- 각 샤드를 담당하는 인스턴스에서는 위의 결과에서 본 5개의 데이터가 2, 3개로 나뉘어 저장됨을 확인할 수 있다. 
![](https://github.com/ohksj77/mongodb-sharded-cluster/assets/89020004/d82866f5-383e-4b1c-a1dd-3377b9cab91b)
![](https://github.com/ohksj77/mongodb-sharded-cluster/assets/89020004/591a6b4a-eb24-47ab-8ada-148cd7d0a6c0)
