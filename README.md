To reproduce the issue within AWS ECR:

Enable the `containerd image store` as per https://docs.docker.com/build/cache/backends/ by adding the following to the Docker features:

```
"features": {
    "containerd-snapshotter": true
}
```

ref: https://docs.docker.com/engine/storage/containerd/#enable-containerd-image-store-on-docker-engine

Sign in to AWS ECR:

```
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 211125654114.dkr.ecr.us-east-2.amazonaws.com
```

Build this image:

```
docker build -t 211125654114.dkr.ecr.us-east-2.amazonaws.com/test-immutable:bar .
```

Push this image:

```
docker push 211125654114.dkr.ecr.us-east-2.amazonaws.com/test-immutable:bar
```

This yields:

```
failed commit on ref "manifest-sha256:b1046f6218c477a57f78da412bdf0e9225359b4f46f01a30f7929a3517a59e5f": unexpected status from PUT request to https://211125654114.dkr.ecr.us-east-2.amazonaws.com/v2/test-immutable/manifests/bar: 400 Bad Request
```
