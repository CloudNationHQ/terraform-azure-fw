.PHONY: test

export TF_PATH

test:
	cd tests && go test -v -timeout 60m -run TestApplyNoError/$(TF_PATH) ./fw_test.go
