docker build -t seneka810/multi-client:latest -t seneka810/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t seneka810/multi-server:latest -t seneka810/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t seneka810/multi-worker:latest -t seneka810/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push seneka810/multi-client:latest
docker push seneka810/multi-server:latest
docker push seneka810/multi-worker:latest

docker push seneka810/multi-client:$SHA
docker push seneka810/multi-server:$SHA
docker push seneka810/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=seneka810/multi-server:$SHA
kubectl set image deployments/client-deployment client=seneka810/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=seneka810/multi-worker:$SHA