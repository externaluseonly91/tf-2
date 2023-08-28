# tf-2


![casp-1](https://github.com/externaluseonly91/tf-2/assets/134925902/351f1f5a-b5d7-43cb-8c25-f53b8965c01f)

![casp-2](https://github.com/externaluseonly91/tf-2/assets/134925902/f0f57497-afc0-481a-8525-dfa929d6c26b)

![casp-3](https://github.com/externaluseonly91/tf-2/assets/134925902/3518b0cc-0370-4822-9c05-0aaa73bfb795)

![casp-4](https://github.com/externaluseonly91/tf-2/assets/134925902/1d96ee08-2716-437e-ae34-2b12f23b5e57)




### Dockerfile.rails
```
FROM ruby:3.1.3 AS rails-env
RUN apt-get update -y
RUN apt-get install -y postgresql-client
# Set environment variables for PostgreSQL connection
ENV POSTGRES_PASSWORD=pass
ENV POSTGRES_DB=db
ENV POSTGRES_USER=git
ENV POSTGRES_PORT=5432
ENV POSTGRES_HOST=db
WORKDIR /app
COPY api .
RUN gem install rails bundler
RUN bundle install
ENTRYPOINT ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

```


![Screenshot 2023-08-28 at 16 40 13](https://github.com/externaluseonly91/tf-2/assets/134925902/024863ae-e594-4ca6-8336-d05f90e70e1e)


![Screenshot 2023-08-28 at 16 38 18](https://github.com/externaluseonly91/tf-2/assets/134925902/dac52f5e-a6b0-4e0f-bb5a-4dbf75d31931)

here to access the service publically i have used Nodeport

```
/tf-2/my-app/charts/api$ cat values.yaml 

# Define default values
replicaCount: 1
image:
  repository: ghcr.io/externaluseonly91/api
  tag: latest
  pullPolicy: Always
service:
  type: NodePort
  port: 31000
  targetPort: 3000

# Environment variables
env:
  REDIS_URL: redis://redis:6379/1
  DB_HOST: db
  DB_USER: postgres
  DB_PASS: password

# Resource requests and limits
resources:
  requests:
    memory: "256Mi"
    cpu: "100m"
  limits:
    memory: "512Mi"
    cpu: "200m"

```

```
/tf-2/my-app/charts/api/templates$ cat api-service.yaml 
#apiVersion: v1
#kind: Service
#metadata:
#  name: api
#spec:
#  selector:
#    app: api
#  ports:
#    - protocol: TCP
#      port: 3000

apiVersion: v1
kind: Service
metadata:
  name: api
spec:
  selector:
    app: api
  type: NodePort  # Change the service type to NodePort
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
      nodePort: 31000  # Specify your desired NodePort value
```


packages

https://github.com/externaluseonly91?tab=packages

![image](https://github.com/externaluseonly91/tf-2/assets/134925902/df8fe864-b83b-4b26-92f8-6d8972bc618b)
