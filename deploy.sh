docker build -t 469996/multi-client:latest 469996/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 469996/multi-server:latest 469996/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 469996/multi-worker:latest 469996/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 469996/multi-client:latest
docker push 469996/multi-server:latest
docker push 469996/multi-worker:latest

docker push 469996/multi-client:$SHA
docker push 469996/multi-server:$SHA
docker push 469996/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA