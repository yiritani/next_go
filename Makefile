pull_protos:
	git subtree pull --prefix=proto git@github.com:yiritani/next_go_proto.git main --squash

protoc_go:
	cd sdk/golang && buf generate
