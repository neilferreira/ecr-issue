## Objective

I would like to be able to use local (or registry) based build cache storage backends within my AWS CDK projects. AWS CDK creates an ECR repository as part of it's `bootstrap` process that is immutable by default. As it stands, you can not push anything to this immutable ECR repository at all once you've enabled the containerd image store in Docker.

## Reproducing the issue

To reproduce the issue within AWS ECR:

Enable the `containerd image store` as per https://docs.docker.com/build/cache/backends/ by following one of the following options.

1. Using containerd for pulling and storing images on Docker destkop: https://docs.docker.com/desktop/containerd/#enable-the-containerd-image-store

2. Enable containerd image store on Docker Engine: https://docs.docker.com/engine/storage/containerd/#enable-containerd-image-store-on-docker-engine

Once containerd is eanbled and in use:

Create an IMMUTABLE ECR repository:

```
aws ecr create-repository --image-tag-mutability IMMUTABLE --repository-name tester
```

Sign in to AWS ECR:

```
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 211125654114.dkr.ecr.us-east-2.amazonaws.com
```

Build this image:

```
docker build -t 211125654114.dkr.ecr.us-east-2.amazonaws.com/tester:bar .
```

Push this image:

```
docker push 211125654114.dkr.ecr.us-east-2.amazonaws.com/tester:bar
```

This yields:

```
failed commit on ref "manifest-sha256:c464ef84ed0decc225c0913deec2153b8ef013b195ece219f890a05e96d86e1f": unexpected status from PUT request to https://211125654114.dkr.ecr.us-east-2.amazonaws.com/v2/tester/manifests/bar: 400 Bad Request
```
