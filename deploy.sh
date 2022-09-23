docker build -t alvinotutu/multi-client:latest -t alvinotutu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvinotutu/multi-worker:latest -t alvinotutu/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker build -t alvinotutu/multi-server:latest -t alvinotutu/multi-server:$SHA -f ./client/Dockerfile ./server
docker push alvinotutu/multi-worker:latest
docker push alvinotutu/multi-client:latest
docker push alvinotutu/multi-server:latest

docker push alvinotutu/multi-worker:$SHA
docker push alvinotutu/multi-client:$SHA
docker push alvinotutu/multi-server:$SHA

kubectl apply -f k8s
docker set image deployment/server-deployment server=alvinotutu/multi-server:$SHA
docker set image deployment/worker-deployment worker=alvinotutu/multi-worker:$SHA
docker set image deployment/client-deployment worker=alvinotutu/multi-client:$SHA