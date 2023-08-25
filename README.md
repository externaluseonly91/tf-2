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
