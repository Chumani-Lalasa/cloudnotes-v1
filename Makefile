IMAGE = localhost:5001/cloudnotes
VERSION ?= 1.0.0

build:
	docker build -t $(IMAGE):$(VERSION) -t $(IMAGE):latest .

push:
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest

all: build push
