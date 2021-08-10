docker build -t arifinrobert/multi-client:latest -t arifinrobert/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arifinrobert/multi-server:latest -t arifinrobert/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t arifinrobert/multi-worker:latest -t arifinrobert/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push arifinrobert/multi-client:latest
docker push arifinrobert/multi-server:latest
docker push arifinrobert/multi-worker:latest

docker push arifinrobert/multi-client:$SHA
docker push arifinrobert/multi-server:$SHA
docker push arifinrobert/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arifinrobert/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client
kubectl set image deployments/worker-deployment worker=arifinrobert/multi-worker:$SHA
