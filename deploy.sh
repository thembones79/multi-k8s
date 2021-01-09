docker build -t szumnarski/multi-client:latest -t szumnarski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t szumnarski/multi-server:latest -t szumnarski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t szumnarski/multi-worker:latest -t szumnarski/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push szumnarski/multi-client:latest
docker push szumnarski/multi-server:latest
docker push szumnarski/multi-worker:latest
docker push szumnarski/multi-client:$SHA
docker push szumnarski/multi-server:$SHA
docker push szumnarski/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=szumnarski/multi-server:$SHA
kubectl set image deployments/client-deployment client=szumnarski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=szumnarski/multi-worker:$SHA